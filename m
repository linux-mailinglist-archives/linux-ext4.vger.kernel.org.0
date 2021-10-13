Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F97642B739
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Oct 2021 08:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhJMGcs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Oct 2021 02:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbhJMGcr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Oct 2021 02:32:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D414EC061753
        for <linux-ext4@vger.kernel.org>; Tue, 12 Oct 2021 23:30:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id t184so697330pfd.0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Oct 2021 23:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VuQ9K07zKhFVmW27yAURvZgXNg5Kde2VB7A9n6/jcRM=;
        b=UofdAPLwzqN9irjKYpz7rqdpJba6YSanghzltJ7hygDQHnFxjoYnCn4YD0xclCWyyn
         1QGVCjAoCfMyHBxT5bED+JODP9R8TqKO5BZ3Ypckfrxuser3a0TwMhxL4/T0VMAtKJpU
         VKx0vRkqgm8Bnukgx8yTpvFmvLGoFoDP/yYAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VuQ9K07zKhFVmW27yAURvZgXNg5Kde2VB7A9n6/jcRM=;
        b=zzpvgKecQHqsmZ9eR0qOsVpzszcq1ZOEr79b3Tq+cPIsS3uUFKOPmK60mGvuNqaNzd
         huhEBq2MLJjpEkP/x8gu3JqCjyL8KEzAzwVv+ff9eP05qEKsJbMIWyRPmEG99x5UFVTQ
         Of+XHnKxikurSmB6dsD8gZPrJ9XoaP9V0NGRBb05nZJrQrDUdLCLfVWqjQQLq+1kpT5y
         COXnbiSeeFM5mcKfKoe4qyPoEa8nFOLDSPlKGagaCaFIvbn9Ab6URGzHH8YB8k5EVApy
         IH6K1yB8IXu8rwJk867UrNaY/zePdeS5VNU5cpOceSBudM1WMtKQlNVUbHuf8b4ECRW2
         Izdw==
X-Gm-Message-State: AOAM533f5yl9RvLv6ABCB5mgpDe1USuTSeY7ipDmVFOOmZvWR1x6l58a
        eRMn5YDzxXX+f5eT8XClEqFgqw==
X-Google-Smtp-Source: ABdhPJxi3MilTVqoy9Kf7ydXOCYXbOlyCyon1KO3ew5UZssKOax53PkSESvwHqWMi+XXw8wleT4Yrw==
X-Received: by 2002:a05:6a00:ccb:b0:44c:eb4b:f24e with SMTP id b11-20020a056a000ccb00b0044ceb4bf24emr25691167pfv.16.1634106644424;
        Tue, 12 Oct 2021 23:30:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z10sm12678073pfn.70.2021.10.12.23.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:30:44 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:30:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 25/29] ext4: use sb_bdev_nr_blocks
Message-ID: <202110122330.6E549D2@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-26-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-26-hch@lst.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:38AM +0200, Christoph Hellwig wrote:
> Use the sb_bdev_nr_blocks helper instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0775950ee84e3..3dde8be5df490 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4468,7 +4468,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  		goto cantfind_ext4;
>  
>  	/* check blocks count against device size */
> -	blocks_count = sb->s_bdev->bd_inode->i_size >> sb->s_blocksize_bits;
> +	blocks_count = sb_bdev_nr_blocks(sb);

Wait, my bad. Yes, this is fine. It's going through two helpers. :)

Reviewed-by: Kees Cook <keescook@chromium.org>


>  	if (blocks_count && ext4_blocks_count(es) > blocks_count) {
>  		ext4_msg(sb, KERN_WARNING, "bad geometry: block count %llu "
>  		       "exceeds size of device (%llu blocks)",
> -- 
> 2.30.2
> 

-- 
Kees Cook
