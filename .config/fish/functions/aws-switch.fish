function aws-switch --description 'Switch the `aws` command between v1 and v2'
    mkdir -p $HOME/.local/bin
    switch "$argv[1]"
        case 1 v1
            ln -sf /usr/bin/aws $HOME/.local/bin/aws
            echo "Switched to AWS CLI v1 ("(/usr/bin/aws --version 2>&1)")"
        case 2 v2
            ln -sf $HOME/.local/aws-cli/v2/current/bin/aws $HOME/.local/bin/aws
            echo "Switched to AWS CLI v2 ("($HOME/.local/aws-cli/v2/current/bin/aws --version 2>&1)")"
        case '*'
            set -l current (readlink $HOME/.local/bin/aws 2>/dev/null; or echo 'unset')
            echo "Usage: aws-switch [1|2]"
            echo "Current target: $current"
    end
end
