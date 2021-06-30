Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6013B8683
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 17:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhF3PxF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 11:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235726AbhF3PxE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Jun 2021 11:53:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A737613D9;
        Wed, 30 Jun 2021 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625068235;
        bh=m60QU8P/LzyyZeyUlPXazWqeeicaElvjjPQ2Ohfh9KE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYv6qj35sJz+M5olU3fQmnayBYDZ53RHNc3dL181K4pkB17mY+pYw6/0WCp1bJKV8
         vju6KCi78B17MZkenPbYyFobwO2/dZ9sUsfXCjZDCySRNlha1dkGPWqjyID1ccVNo/
         vpGTIzyUnlm0FkOVjBjluvtx4o3AuvOuPLbLJdz+aEecd8rxSnqgAmbSHi/3DQP8gz
         0oARCSGby6rMnbHz2jTZSVl+CE4V0ubaHjZ9YR39YlKOM853Uqedk+NF4PWr/PJZkt
         5hcQvJGrFd74WxdNf6I5ZZZpCJV1xIYDwXJ9/MinlwPaBWYqENNZ7DVwzzA8N0ZOJW
         /o40X5gqAf1ow==
Date:   Wed, 30 Jun 2021 08:50:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 8/9] common/attr: Cleanup end of line whitespaces issues
Message-ID: <20210630155035.GB13743@locust>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <9c2d87969d29f34e0939fa3a524886e343fb96bb.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c2d87969d29f34e0939fa3a524886e343fb96bb.1623651783.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 14, 2021 at 11:58:12AM +0530, Ritesh Harjani wrote:
> This patch clears the end of line whitespace issues in this file.
> Mostly since many kernel developers also keep this editor config to clear
> any end of line whitespaces on file save.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/attr | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/common/attr b/common/attr
> index 42ceab92..d3902346 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -59,10 +59,10 @@ _acl_setup_ids()
>          j=1
>          for(i=1; i<1000000 && j<=3;i++){
>            if (! (i in ids)) {
> -	     printf "acl%d=%d;", j, i;		 
> +	     printf "acl%d=%d;", j, i;
>  	     j++
>            }
> -        }	
> +        }
>        }'`
>  }
>  
> @@ -101,7 +101,7 @@ _getfacl_filter_id()
>  _acl_ls()
>  {
>      _ls_l -n $* | awk '{ print $1, $3, $4, $NF }' | _acl_filter_id
> -} 
> +}
>  
>  # create an ACL with n ACEs in it
>  #
> @@ -128,7 +128,7 @@ _filter_aces()
>  	BEGIN {
>  	    FS=":"
>  	    while ( getline <tmpfile > 0 ) {
> -		idlist[$1] = $3 
> +		idlist[$1] = $3
>  	    }
>  	}
>  	/^user/ { if ($2 in idlist) sub($2, idlist[$2]); print; next}
> @@ -180,17 +180,17 @@ _require_attrs()
>  {
>  	local args
>  	local nsp
> -	
> +
>  	if [ $# -eq 0 ]; then
>  		args="user"
>  	else
>  	  	args="$*"
>  	fi
> -	
> +
>  	[ -n "$ATTR_PROG" ] || _notrun "attr command not found"
>  	[ -n "$GETFATTR_PROG" ] || _notrun "getfattr command not found"
>  	[ -n "$SETFATTR_PROG" ] || _notrun "setfattr command not found"
> -	
> +
>  	for nsp in $args; do
>  		#
>  		# Test if chacl is able to write an attribute on the target
> @@ -204,14 +204,14 @@ _require_attrs()
>  		touch $TEST_DIR/syscalltest
>  		$SETFATTR_PROG -n "$nsp.xfstests" -v "attr" $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
>  		cat $TEST_DIR/syscalltest.out >> $seqres.full
> -		
> +
>  		if grep -q 'Function not implemented' $TEST_DIR/syscalltest.out; then
>  			_notrun "kernel does not support attrs"
>  		fi
>  		if grep -q 'Operation not supported' $TEST_DIR/syscalltest.out; then
>  			_notrun "attr namespace $nsp not supported by this filesystem type: $FSTYP"
>  		fi
> -		
> +
>  		rm -f $TEST_DIR/syscalltest.out
>  	done
>  }
> -- 
> 2.31.1
> 
