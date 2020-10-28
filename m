Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A94529D611
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Oct 2020 23:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbgJ1WLe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Oct 2020 18:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbgJ1WLd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Oct 2020 18:11:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B51C0613D1
        for <linux-ext4@vger.kernel.org>; Wed, 28 Oct 2020 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RJipvKeo6bBp4cPWGXHfpRPcW39oO1hr0FF/uzNT9Bc=; b=cYP454buF6rSUDA8DaA4NtBD+i
        Jkt3a3bodzkYFWwfOdorISSnbba5yG40PcmqIsNgkcUkhJlN1f10UyBQLp7Y2YR9EHaHnRfa9GXuY
        UaBuqAjxw9u9FSLQZMfTt/Pl7fIfw7HrO4OWAndKZZaMMOb6EaQSPhRO/0esbWE6Y8keHqsI6lxWX
        pD06lCUHKjZ2REd7Dll9rb0pysHXvD7E/TNfZ08EghrzbVChuHNb7BxpJaLN0bYMygCtphpqKuh9I
        g5zW54ZQ8omcooloQqdxobWQTzom9CPbsNH//k2s1DBymTm+zR95iqV3SklbxQXyTOoXNEQFH/k1W
        vbf7D4DA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXg59-0000l6-SR; Wed, 28 Oct 2020 07:41:19 +0000
Date:   Wed, 28 Oct 2020 07:41:19 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     guaneryu@gmail.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/9] common: extract rt extent size for
 _get_file_block_size
Message-ID: <20201028074119.GA2750@infradead.org>
References: <160382528936.1202316.2338876126552815991.stgit@magnolia>
 <160382529579.1202316.931742119756545034.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160382529579.1202316.931742119756545034.stgit@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 27, 2020 at 12:01:35PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> _get_file_block_size is intended to return the size (in bytes) of the
> fundamental allocation unit for a file.  This is required for remapping
> operations like fallocate and reflink, which can only operate on
> allocation units.  Since the XFS realtime volume can be configure for
> allocation units larger than 1 fs block, we need to factor that in here.

Should this also cover the ext4 bigalloc clusters?  Or do they not
matter for fallocate?

> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  common/rc  |   13 ++++++++++---
>  common/xfs |   20 ++++++++++++++++++++
>  2 files changed, 30 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/common/rc b/common/rc
> index 27a27ea3..41f93047 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3974,11 +3974,18 @@ _get_file_block_size()
>  		echo "Missing mount point argument for _get_file_block_size"
>  		exit 1
>  	fi
> -	if [ "$FSTYP" = "ocfs2" ]; then
> +
> +	case "$FSTYP" in
> +	"ocfs2")
>  		stat -c '%o' $1
> -	else
> +		;;
> +	"xfs")
> +		_xfs_get_file_block_size $1
> +		;;
> +	*)
>  		_get_block_size $1
> -	fi
> +		;;
> +	esac
>  }
>  
>  # Get the minimum block size of an fs.
> diff --git a/common/xfs b/common/xfs
> index 79dab058..3f5c14ba 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -174,6 +174,26 @@ _scratch_mkfs_xfs()
>  	return $mkfs_status
>  }
>  
> +# Get the size of an allocation unit of a file.  Normally this is just the
> +# block size of the file, but for realtime files, this is the realtime extent
> +# size.
> +_xfs_get_file_block_size()
> +{
> +	local path="$1"
> +
> +	if ! ($XFS_IO_PROG -c "stat -v" "$path" 2>&1 | egrep -q '(rt-inherit|realtime)'); then
> +		_get_block_size "$path"
> +		return
> +	fi
> +
> +	# Otherwise, call xfs_info until we find a mount point or the root.
> +	path="$(readlink -m "$path")"
> +	while ! $XFS_INFO_PROG "$path" &>/dev/null && [ "$path" != "/" ]; do
> +		path="$(dirname "$path")"
> +	done
> +	$XFS_INFO_PROG "$path" | grep realtime | sed -e 's/^.*extsz=\([0-9]*\).*$/\1/g'
> +}
> +
>  # xfs_check script is planned to be deprecated. But, we want to
>  # be able to invoke "xfs_check" behavior in xfstests in order to
>  # maintain the current verification levels.
> 
---end quoted text---
