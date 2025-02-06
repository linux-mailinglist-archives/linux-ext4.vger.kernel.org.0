Return-Path: <linux-ext4+bounces-6353-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF08A2AC69
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 16:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CF41882A55
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2025 15:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DED1EDA27;
	Thu,  6 Feb 2025 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="SUImpTrK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3A7223323
	for <linux-ext4@vger.kernel.org>; Thu,  6 Feb 2025 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855471; cv=none; b=ZsWWnilv/xyHUl0kxmr7mYjF/NMwU6Vk3Asf/auo32/rZI6adWFCGzKfeCccvHEKqgKCo5oLxlFiPIZ7YeRFyx7zfv0UZ5J6+ydoPG09MP+S6hFb275K3ExVseh2hKiAQ9tmtVj/DAYYtuqEJjWoMZ8v/Kc9zr8qVihrVK+Mrco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855471; c=relaxed/simple;
	bh=+mhTwhnRkBauLKtkjqvsL/JJbt9U3QlU6+MvefYbSEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4UwbHRAfDucxKjx1PNuiW/Ji6tjKi8eCG2yAveFWMZ6ztsBifyJZHPvD/eT7ih0w2bNsVCHxqR0j/mGICmqKD18dYcmEMWh8m1gg+v2Xnwe27bmilKNbhVvJA7/AwbDTaVDRk9h2+1RQLHqQFHSgn7W7l6w6zF4vGsJX8NAQrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=SUImpTrK; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-148.bstnma.fios.verizon.net [173.48.111.148])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 516FOJ2N022537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Feb 2025 10:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738855462; bh=xMQg9S37A/mi+FgxpYqORfsNV3gJWTlUd7uNx3gBE88=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=SUImpTrK1yceDrU3aYwenVmRjnoug2GVo/WJokR4N9XYujDbHNjuo6MMoVQ7gr06i
	 eehYuEEr13TYq9lSSyO6xXJzfE1MJglKAsPRUV8GXRu0N7EHYCcpU5OFLNmqbDR65R
	 Y4EbZcVlXFIr9VrTqyXIBCsJ0WoN9LEPunQIuiZK7wYj9rmUEuZccovBK58fCCQgUL
	 k6vX+xXYfaUuZOkPCD2Lo2ztqGVLsQ0+PAMfVo11cZX1Jfpvt0j5fmp1fE80kGTgGb
	 5PcNLunpC5dsBRbKAJG3F6J+qin/5sjItArOzJne1jga6RDxTdjxTk5Fnrn4qFvszH
	 /sRWIWQANGfwA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 594D215C013F; Thu, 06 Feb 2025 10:24:19 -0500 (EST)
Date: Thu, 6 Feb 2025 10:24:19 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org,
        syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] ext4: Verify fast symlink length
Message-ID: <20250206152419.GB1130956@mit.edu>
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
> +				ext4_error_inode(inode, function, line, 0,
> +					"invalid fast symlink length %llu",
> +					 (unsigned long long)inode->i_size);
> +				ret = -EFSCORRUPTED;
> +				goto bad_inode;
> +			}
>  			inode_set_cached_link(inode, (char *)ei->i_data,
>  					      inode->i_size);


I don't think this will do the right thing if the fast symlink is
encrypted.  See ext4_encrypted_get_link() in fs/ext4/symlink.c in the
kernel sources, and also look at how e2fsck_pass1_check_symlink()
handles checking the size of an encrypted, fast symlink.

Thanks,

					- Ted

