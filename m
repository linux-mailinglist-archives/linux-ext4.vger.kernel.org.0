Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5F428B1A7
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Oct 2020 11:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgJLJdU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 05:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbgJLJdR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 12 Oct 2020 05:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602495196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ODLqXtIJXCh65xKBlGCkC/HJeSUR67h1b84gdjbmHd4=;
        b=JYtZKvdMRkKDnNh3dZtNMAGRNoeflXEow10o7clCKgIyRjG+1LRL2Sl9tL6VFttmqT6TWC
        nE5/4lzxE6xJrKTC4wx5VhrKNLDe7GHfQhHwuVR1llUrouXDbqRquIkK1yT2S71RSjPhjz
        7AKjUP5porunb3kmJQqdv0itGaJZ3TU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-7D5leMv8MJKSPDiffFE7NA-1; Mon, 12 Oct 2020 05:33:11 -0400
X-MC-Unique: 7D5leMv8MJKSPDiffFE7NA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEE0E1018F63;
        Mon, 12 Oct 2020 09:33:09 +0000 (UTC)
Received: from work (unknown [10.40.194.244])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDBA961177;
        Mon, 12 Oct 2020 09:33:07 +0000 (UTC)
Date:   Mon, 12 Oct 2020 11:33:04 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     xiakaixu1987@gmail.com
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [RFC PATCH] ext4: use the normal helper to get the actual inode
Message-ID: <20201012093304.aevqpvq5sotzamrq@work>
References: <1602317416-1260-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602317416-1260-1-git-send-email-kaixuxia@tencent.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Oct 10, 2020 at 04:10:16PM +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> Here we use the READ_ONCE to fix race conditions in ->d_compare() and
> ->d_hash() when they are called in RCU-walk mode, seems we can use
> the normal helper d_inode_rcu() to get the actual inode.

Looks good to me.
Thanks!

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  fs/ext4/dir.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 1d82336b1cd4..3bf6cb8e55f6 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -674,7 +674,7 @@ static int ext4_d_compare(const struct dentry *dentry, unsigned int len,
>  {
>  	struct qstr qstr = {.name = str, .len = len };
>  	const struct dentry *parent = READ_ONCE(dentry->d_parent);
> -	const struct inode *inode = READ_ONCE(parent->d_inode);
> +	const struct inode *inode = d_inode_rcu(parent);
>  	char strbuf[DNAME_INLINE_LEN];
>  
>  	if (!inode || !IS_CASEFOLDED(inode) ||
> @@ -706,7 +706,7 @@ static int ext4_d_hash(const struct dentry *dentry, struct qstr *str)
>  {
>  	const struct ext4_sb_info *sbi = EXT4_SB(dentry->d_sb);
>  	const struct unicode_map *um = sbi->s_encoding;
> -	const struct inode *inode = READ_ONCE(dentry->d_inode);
> +	const struct inode *inode = d_inode_rcu(dentry);
>  	unsigned char *norm;
>  	int len, ret = 0;
>  
> -- 
> 2.20.0
> 

