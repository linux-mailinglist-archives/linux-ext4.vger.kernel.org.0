Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFDA7E11CA
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 07:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfJWFou (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Oct 2019 01:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729233AbfJWFou (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Oct 2019 01:44:50 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C1BA2173B;
        Wed, 23 Oct 2019 05:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571809489;
        bh=qv6OkyuwuHFLJc2lOZAfkkZ73EL6UqgUWYM2tnooTaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GyHp4wqoR3EST8V51UxYHzareLgqFn2QIND/mvztJUtGoQX6zEAZWw9qvhODNdEsR
         QGnUC+6YB2/8Yj4t315P+kiS2Fodt+F1uqWc4sclO1trnHQhgb+TNDN7PSLE54/Q/R
         rFOYPRHetzkZiWZHroDT85TDLeeBPw/51d91th3s=
Date:   Tue, 22 Oct 2019 22:44:47 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        stable@kernel.org
Subject: Re: [PATCH] ext4: fix signed vs unsigned comparison in
 ext4_valid_extent()
Message-ID: <20191023054447.GE361298@sol.localdomain>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        stable@kernel.org
References: <20191023013112.18809-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023013112.18809-1-tytso@mit.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 22, 2019 at 09:31:12PM -0400, Theodore Ts'o wrote:
> Due to a signed vs unsigned comparison, an invalid extent where
> ee_block (the logical block) is so large that lblk + len overflow
> wasn't getting flagged as invalid.
> 
> As a result, we tripped the BUG_ON(end < lblk) in
> ext4_es_cache_extent() when trying to mount a file system with a
> corrupted journal inode was corrupted.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=205197
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Cc: stable@kernel.org
> ---
>  fs/ext4/extents.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index fb0f99dc8c22..d12bc287abdc 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -367,7 +367,7 @@ ext4_ext_max_entries(struct inode *inode, int depth)
>  static int ext4_valid_extent(struct inode *inode, struct ext4_extent *ext)
>  {
>  	ext4_fsblk_t block = ext4_ext_pblock(ext);
> -	int len = ext4_ext_get_actual_len(ext);
> +	unsigned int len = ext4_ext_get_actual_len(ext);
>  	ext4_lblk_t lblock = le32_to_cpu(ext->ee_block);
>  
>  	/*
> -- 
> 2.23.0
> 

This patch can't be fixing anything because the comparison is unsigned both
before and after this patch.

- Eric
