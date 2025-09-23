Return-Path: <linux-ext4+bounces-10377-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B61B97CEE
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Sep 2025 01:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB54C2EA9
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Sep 2025 23:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9856230FC3B;
	Tue, 23 Sep 2025 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btKodySf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3650217A5BE;
	Tue, 23 Sep 2025 23:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758670775; cv=none; b=u2gXb7kXa56xHoDpz3i+b1JlOyQbNCH54tBaW08KscMH2XVYtsaFY0Zz0fy7i1hwYMTamaJiDJfbteA1rgkszNTzZLDxH/MMrT3tYVvUkQTrn3nF276RV3dv/Yavu8qf/m7lVZGlw0olUKR67ArNbAlnKz6L2rb7Dkc/Wuq9s3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758670775; c=relaxed/simple;
	bh=h+EdEdNZHSQ1hSsUTnQv1Sa+TLUPz0+HmIemtZK2eQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rws0Tr+H6DT08bYK+67Zem1bIyCJA3nnbp72J6d6YWb1+EK0MUuzQixR37y/NFCRnCrkgxCYY27gQyAuuIgIktepEui+qzhJ5ZLvYIAXjwBTJvaSVgKByVUxRnX0GuYHNiqbhIXz3cnLSgIVG9OQgvtB64ztnyDZcKQEAV7aCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btKodySf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22B6C4CEF5;
	Tue, 23 Sep 2025 23:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758670774;
	bh=h+EdEdNZHSQ1hSsUTnQv1Sa+TLUPz0+HmIemtZK2eQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btKodySfh+IdtmJ0nqMAYqlVvJGuJyYTq5VyPsAS4NXsn0UcNVyGCSpOmPBhNCD+A
	 TAgQLivGJHP44qILT7p/qgX9xtMah0jLLredSkZ8eiPVh6NaYnBSsdRpy1yJ7Q7fdy
	 xloocDTSipHILrj9P54qqiuzH4VCLjrrYbpZF4eCmVWSv5rKBQSOki7pmlQE5fBTnF
	 Q+xhvtKBrS3jEIR+7+yWRGqmS426YiXWZLAQMGVlMpgq7/wqCR4/WwMrOpJVS6WFFY
	 /K0vMloRwTn929tU+gMoujF4byqXoJtX6m7pyEkZHsFoASFIaUjz+NGcEo5XMIM8rw
	 7GSBQ/Gvz7+wQ==
Date: Tue, 23 Sep 2025 16:39:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: Re: [PATCH v2] Fix: ext4: guard against EA inode refcount underflow
 in xattr update
Message-ID: <20250923233934.GJ8084@frogsfrogsfrogs>
References: <20250918175545.48297-1-eraykrdg1@gmail.com>
 <20250920021342.45575-1-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920021342.45575-1-eraykrdg1@gmail.com>

On Sat, Sep 20, 2025 at 05:13:43AM +0300, Ahmet Eray Karadag wrote:
> syzkaller found a path where ext4_xattr_inode_update_ref() reads an EA
> inode refcount that is already <= 0 and then applies ref_change (often
> -1). That lets the refcount underflow and we proceed with a bogus value,
> triggering errors like:
> 
>   EXT4-fs error: EA inode <n> ref underflow: ref_count=-1 ref_change=-1
>   EXT4-fs warning: ea_inode dec ref err=-117
> 
> Make the invariant explicit: if the current refcount is non-positive,
> treat this as on-disk corruption, emit ext4_error_inode(), and fail the
> operation with -EFSCORRUPTED instead of updating the refcount. Delete the
> WARN_ONCE() as negative refcounts are now impossible; keep error reporting
> in ext4_error_inode().
> 
> This prevents the underflow and the follow-on orphan/cleanup churn.
> 
> Reported-by: syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com
> Fixes: https://syzbot.org/bug?extid=0be4f339a8218d2a5bb1
> Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
> Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
> ---
> v2:
>  - Move underflow guard before the update
>  - Add overflow guard for the opposite case
>  - Use u64 type instead s64, since ext4_xattr_inode_update_ref() returns u64 and ext4_xattr_inode_set_ref() expects u64.
> 
> ---
>  fs/ext4/xattr.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 5a6fe1513fd2..a510693e04ac 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1019,7 +1019,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
>  				       int ref_change)
>  {
>  	struct ext4_iloc iloc;
> -	s64 ref_count;
> +	u64 ref_count;
>  	int ret;
>  
>  	inode_lock_nested(ea_inode, I_MUTEX_XATTR);
> @@ -1029,13 +1029,17 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
>  		goto out;
>  
>  	ref_count = ext4_xattr_inode_get_ref(ea_inode);
> +	if ((ref_count == 0 && ref_change < 0) || (ref_count == U64_MAX && ref_change > 0)) {

/me wonders if you could use check_add_overflow for this, but otherwise
everthing looks fine to me...

> +		ext4_error_inode(ea_inode, __func__, __LINE__, 0,
> +			"EA inode %lu ref wraparound: ref_count=%lld ref_change=%d",

Nit: %llu since ref_count is now unsigned.

> +			ea_inode->i_ino, ref_count, ref_change);
> +		ret = -EFSCORRUPTED;
> +		goto out;
> +	}
>  	ref_count += ref_change;
>  	ext4_xattr_inode_set_ref(ea_inode, ref_count);
>  
>  	if (ref_change > 0) {
> -		WARN_ONCE(ref_count <= 0, "EA inode %lu ref_count=%lld",
> -			  ea_inode->i_ino, ref_count);
> -
>  		if (ref_count == 1) {
>  			WARN_ONCE(ea_inode->i_nlink, "EA inode %lu i_nlink=%u",
>  				  ea_inode->i_ino, ea_inode->i_nlink);

...though while you're modifying the precondition checking here, I think
these i_nlink preconditions should also be hoisted to the top and cause
an EFSCORRUPTED return on bad inputs.

--D

> @@ -1044,9 +1048,6 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
>  			ext4_orphan_del(handle, ea_inode);
>  		}
>  	} else {
> -		WARN_ONCE(ref_count < 0, "EA inode %lu ref_count=%lld",
> -			  ea_inode->i_ino, ref_count);
> -
>  		if (ref_count == 0) {
>  			WARN_ONCE(ea_inode->i_nlink != 1,
>  				  "EA inode %lu i_nlink=%u",
> -- 
> 2.34.1
> 
> 

