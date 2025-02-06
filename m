Return-Path: <linux-ext4+bounces-6354-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE38A2AC81
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 16:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6801633BC
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 15:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20071E5B77;
	Thu,  6 Feb 2025 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIl+wseq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564271EDA19
	for <linux-ext4@vger.kernel.org>; Thu,  6 Feb 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738856051; cv=none; b=dQZ785NJZE384LWee/QTPR7Xii/A8C7qSav3aIBnNax+vEaNsIgcud1ywVGNpIPzNIRHtMtzlh0Y2FwR3Y6U55/WSvO/sIBLuACWRDM5JzsBRd/6jfEageLsbehy7FR0/t+3f699kY1cYUex58yHyBD+ofMnIA358xjiGeXNgJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738856051; c=relaxed/simple;
	bh=Qwv/bE5KLMXnH9iHPKy+D+6yUVBrLWtRDkfZ0Kme6gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MF47XMFPZX3FJZr9ympPtS5Cgw6bvDqQoSUOUSnOvv0Fr+jR1xv8om61kMFmffJHyEy5422bmzKMqoaMhBM3ibawuquM/G9vkUYC2wsMzf0ViD+aotB5V4nYoyfKt/fJYEh+DovWHA0UXHIqwD1/EAD8OH/70x+a5fpHzybcvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIl+wseq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA9DC4CEDD;
	Thu,  6 Feb 2025 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738856049;
	bh=Qwv/bE5KLMXnH9iHPKy+D+6yUVBrLWtRDkfZ0Kme6gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIl+wseqRRnYJwiqlFDuS6Ac6fPPvXbV+kW2dFDUJp10k0d0GQeR+95L8q6G9Ylhc
	 jeIEeO6zaOD14Ni5K9vOP43zNU8iYQVtQ37u0ummexknMPEbxbBoYGJpvlKmZ5/NP/
	 +ml/u1Z/N/MBpu+j4rBycG9XJCQnmkzW/GZ5DMMDfRKs6xHVLVvV7PfpFPSrfbpFO5
	 8psWLu10GHDeuM5wTLiTEBj/ocCnJXvenNBvG15bWOpQpRAk+cjoC/FtlJmk4sOANE
	 zVMimpl/aNhV1J0QlWesS8L/kaCJtfAqZCNzDc3ma4gA8fTsP+pMksBmwaQ37homwg
	 lhwVvlxL4hFAg==
Date: Thu, 6 Feb 2025 07:34:09 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Verify fast symlink length
Message-ID: <20250206153409.GJ21828@frogsfrogsfrogs>
References: <20250206094454.20522-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206094454.20522-2-jack@suse.cz>

On Thu, Feb 06, 2025 at 10:44:55AM +0100, Jan Kara wrote:
> Verify fast symlink length stored in inode->i_size matches the string
> stored in the inode to avoid surprises from corrupted filesystems.
> 
> Reported-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> Tested-by: syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
> Fixes: bae80473f7b0 ("ext4: use inode_set_cached_link()")
> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 7c54ae5fcbd4..64e280fed911 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5007,8 +5007,16 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>  			inode->i_op = &ext4_encrypted_symlink_inode_operations;
>  		} else if (ext4_inode_is_fast_symlink(inode)) {
>  			inode->i_op = &ext4_fast_symlink_inode_operations;
> -			nd_terminate_link(ei->i_data, inode->i_size,
> -				sizeof(ei->i_data) - 1);
> +			if (inode->i_size == 0 ||
> +			    inode->i_size >= sizeof(ei->i_data) ||
> +			    strnlen((char *)ei->i_data, inode->i_size + 1) !=
> +								inode->i_size) {

Oooh, a validation I overlooked!  :D

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> +				ext4_error_inode(inode, function, line, 0,
> +					"invalid fast symlink length %llu",
> +					 (unsigned long long)inode->i_size);
> +				ret = -EFSCORRUPTED;
> +				goto bad_inode;
> +			}
>  			inode_set_cached_link(inode, (char *)ei->i_data,
>  					      inode->i_size);
>  		} else {
> -- 
> 2.43.0
> 

