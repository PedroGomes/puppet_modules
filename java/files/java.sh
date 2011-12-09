java_path=$(update-alternatives --display java | grep 'points to' | cut -c 28- )
jre_path=${java_path%/*/*}

export JAVA_HOME=$jre_path/
export CLASSPATH=${JAVA_HOME}lib/rt.jar:
