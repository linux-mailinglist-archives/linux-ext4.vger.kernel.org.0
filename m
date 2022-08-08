Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E83258C195
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Aug 2022 04:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243891AbiHHC0j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Aug 2022 22:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243924AbiHHC0Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 7 Aug 2022 22:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7054713FB2
        for <linux-ext4@vger.kernel.org>; Sun,  7 Aug 2022 19:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659924589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fp2+CQGzi3KSxNsaZsdYp9vxjcxW5nKXb3Uu0mTJcsM=;
        b=ZQskdFwkBcIbfbpMtr6gtS7JS0LGR4MhQ+iEk7zwZnoJfZRBueHCRo+MfWD3/cmUfTs8iA
        nlJ8L1XD5Nwc94bCQai8UM6X7apwVtTgkZMiPvJcY1s4pRMParrqPlnAdLUBuFETezd2OM
        Ps9ZLO+oU9oPaSuti2hbRvCAqb8KiEw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-P2EzhHGJM3qD7ff6M7gHAA-1; Sun, 07 Aug 2022 22:09:47 -0400
X-MC-Unique: P2EzhHGJM3qD7ff6M7gHAA-1
Received: by mail-pg1-f200.google.com with SMTP id c20-20020a6566d4000000b0041c325bd8ffso2462944pgw.4
        for <linux-ext4@vger.kernel.org>; Sun, 07 Aug 2022 19:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=Fp2+CQGzi3KSxNsaZsdYp9vxjcxW5nKXb3Uu0mTJcsM=;
        b=KG7ZdbslT4bhIPqI28WkBsAmhr4tpCzDemS1+6+1U6nJg4ZWpkjzRrQJ0yMq3k1qlp
         mUyf8X4V4sckIKbN20FxuqjTTC2XNZZxwc7QS8srLG+9HnauFjGzzngJm/CDUWzthdNJ
         M7CRQreRZoH9vD6d/rVUcWDgCed2QVxY9q33rJTAyOHg+Ty/CYYaXVZpe5IpqMko4GmE
         mwFsG/0A8CF/cjYFEGdeVJIWeDwEAkCHjJSIn6rbUvAOuSuNIC/KTfS2k2oyzX02GuPZ
         IkEMQswMAYtk8lJiOPOZNkQPazan+uX7U5XLYasAw7ct+oEx+rRF9gfBvZpfiypaSXkz
         Dsqw==
X-Gm-Message-State: ACgBeo3VK1Y7ItJci4/RUzaDoBkuylmz58yANveVGmx9lT6AFPiOIr5J
        M4XDS4cfPkhGWI6GngYxBXWmQkknzQ7JdpNJh/U6p4jpG2XAYj1KaN/eDi6C5MjkAS0E0H+ozKi
        wb5z5cF3lbzUSlDuT/oB2EA==
X-Received: by 2002:a17:903:18a:b0:16f:9027:60dc with SMTP id z10-20020a170903018a00b0016f902760dcmr13030869plg.147.1659924585825;
        Sun, 07 Aug 2022 19:09:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4zqX7r5qFKMhz9KRWguq7HBIFHBtnusMNNSoWRAijv2u40o8w+3I/4CY4N0UozWx7nIVgbhA==
X-Received: by 2002:a17:903:18a:b0:16f:9027:60dc with SMTP id z10-20020a170903018a00b0016f902760dcmr13030849plg.147.1659924585530;
        Sun, 07 Aug 2022 19:09:45 -0700 (PDT)
Received: from [10.72.12.61] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79597000000b00528c066678csm7312097pfj.72.2022.08.07.19.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 19:09:45 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] vfs: report change attribute in statx for
 IS_I_VERSION inodes
To:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, lczerner@redhat.com, bxue@redhat.com,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>
References: <20220805183543.274352-1-jlayton@kernel.org>
 <20220805183543.274352-2-jlayton@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <8a87ee82-fa04-6b99-8716-9acf24446c5a@redhat.com>
Date:   Mon, 8 Aug 2022 10:09:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220805183543.274352-2-jlayton@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 8/6/22 2:35 AM, Jeff Layton wrote:
> From: Jeff Layton <jlayton@redhat.com>
>
> Claim one of the spare fields in struct statx to hold a 64-bit change
> attribute. When statx requests this attribute, do an
> inode_query_iversion and fill the result in the field.
>
> Also update the test-statx.c program to fetch the change attribute as
> well.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/stat.c                 | 7 +++++++
>   include/linux/stat.h      | 1 +
>   include/uapi/linux/stat.h | 3 ++-
>   samples/vfs/test-statx.c  | 4 +++-
>   4 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/fs/stat.c b/fs/stat.c
> index 9ced8860e0f3..976e0a59ab23 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -17,6 +17,7 @@
>   #include <linux/syscalls.h>
>   #include <linux/pagemap.h>
>   #include <linux/compat.h>
> +#include <linux/iversion.h>
>   
>   #include <linux/uaccess.h>
>   #include <asm/unistd.h>
> @@ -118,6 +119,11 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>   	stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
>   				  STATX_ATTR_DAX);
>   
> +	if ((request_mask & STATX_CHGATTR) && IS_I_VERSION(inode)) {
> +		stat->result_mask |= STATX_CHGATTR;
> +		stat->chgattr = inode_query_iversion(inode);
> +	}
> +
>   	mnt_userns = mnt_user_ns(path->mnt);
>   	if (inode->i_op->getattr)
>   		return inode->i_op->getattr(mnt_userns, path, stat,
> @@ -611,6 +617,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
>   	tmp.stx_dev_major = MAJOR(stat->dev);
>   	tmp.stx_dev_minor = MINOR(stat->dev);
>   	tmp.stx_mnt_id = stat->mnt_id;
> +	tmp.stx_chgattr = stat->chgattr;
>   
>   	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
>   }
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 7df06931f25d..4a17887472f6 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -50,6 +50,7 @@ struct kstat {
>   	struct timespec64 btime;			/* File creation time */
>   	u64		blocks;
>   	u64		mnt_id;
> +	u64		chgattr;
>   };
>   
>   #endif
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 1500a0f58041..b45243a0fbc5 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -124,7 +124,7 @@ struct statx {
>   	__u32	stx_dev_minor;
>   	/* 0x90 */
>   	__u64	stx_mnt_id;
> -	__u64	__spare2;
> +	__u64	stx_chgattr;	/* Inode change attribute */
>   	/* 0xa0 */
>   	__u64	__spare3[12];	/* Spare space for future expansion */
>   	/* 0x100 */
> @@ -152,6 +152,7 @@ struct statx {
>   #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
>   #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
>   #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
> +#define STATX_CHGATTR		0x00002000U	/* Want/git stx_chgattr */

s/git/get/ ?

>   
>   #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
>   
> diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
> index 49c7a46cee07..767208d2f564 100644
> --- a/samples/vfs/test-statx.c
> +++ b/samples/vfs/test-statx.c
> @@ -109,6 +109,8 @@ static void dump_statx(struct statx *stx)
>   		printf(" Inode: %-11llu", (unsigned long long) stx->stx_ino);
>   	if (stx->stx_mask & STATX_NLINK)
>   		printf(" Links: %-5u", stx->stx_nlink);
> +	if (stx->stx_mask & STATX_CHGATTR)
> +		printf(" Change Attr: 0x%llx", stx->stx_chgattr);
>   	if (stx->stx_mask & STATX_TYPE) {
>   		switch (stx->stx_mode & S_IFMT) {
>   		case S_IFBLK:
> @@ -218,7 +220,7 @@ int main(int argc, char **argv)
>   	struct statx stx;
>   	int ret, raw = 0, atflag = AT_SYMLINK_NOFOLLOW;
>   
> -	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME;
> +	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME | STATX_CHGATTR;
>   
>   	for (argv++; *argv; argv++) {
>   		if (strcmp(*argv, "-F") == 0) {

