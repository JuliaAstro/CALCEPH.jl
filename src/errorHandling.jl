

function disableCustomHandler()
    ccall((:calceph_seterrorhandler, libcalceph), Cvoid,
                  (Cint, Ptr{Cvoid}), 1, C_NULL)
end

mutable struct UserHandlerContainer
    f::Function
end

const userHandlerContainerInstance = UserHandlerContainer(s::String->Nothing)

function userHandlerWrapper(msg::Cstring)::Cvoid
    global userHandlerContainerInstance
    s = unsafe_string(msg)
    userHandlerContainerInstance.f(s)
    return
end

#userHandlerCWrapper = @cfunction(userHandlerWrapper, Cvoid, (Cstring,))
userHandlerCWrapper = Nothing

function setCustomHandler(f::Function)
    global userHandlerContainerInstance
    global userHandlerCWrapper
    userHandlerCWrapper = @cfunction(userHandlerWrapper, Cvoid, (Cstring,))
    userHandlerContainerInstance.f = f
    ccall((:calceph_seterrorhandler, libcalceph), Cvoid,
                  (Cint, Ptr{Cvoid}), 3, userHandlerCWrapper)
end
