Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9448C5B17EE
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 11:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIHJD1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 05:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIHJD0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 05:03:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D6EF7577
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 02:03:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m3so6512534pjo.1
        for <linux-ext4@vger.kernel.org>; Thu, 08 Sep 2022 02:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=U5l4s9dEaUIPCl/QmrOpIinbJY+eoGy9YHOo3H3/ByE=;
        b=KbCD1aQ047YzFbZj5LxtggTZcq1SAkRFUOrucrg3VujMw26vH1bewIiQWVeB5kWTcz
         DqqgIMAhPgcgh0ltcLgYsT+co/9p7mRjE+NRaii49d4O284fWCjO9jkeIaSBGkvPrOk+
         1qItDCz/37zQb99SN5HcmQ0o/lyGDp09Zgjlrz+k6DhfmeaF7+1Wo9zr4Zv6YVIyi/m1
         QOtV02Kq0m0T5jOkJoXnmyIKw/cSUidzqB40ofsMZmQqrb5CYTVyB+UsNW9GPnpnLhKM
         h7aXUFIAZNF1F6fmJWODDhCdqmGyQ37csbBCrTL++OU3L6z8OkstSh6qdAv6H2DOWSvz
         wZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=U5l4s9dEaUIPCl/QmrOpIinbJY+eoGy9YHOo3H3/ByE=;
        b=rXqBIDoqu3cm7wHGRR1nLgicGKpxjOmk02hwzvseBP+y1gxUr7f/Of5JZdN7nI9flO
         XmuJHnTZk1cYDINOmQFcQL9i2oHpopPNzOcP2Wvq9u9XolWgU8OhKBNz8hAG3A09AUfu
         H0EzRwxQCxVq58DQgP0FFVizK//sQCykyHLq0cDSKrP2mrm9XkwtdI/A9jV1J1liyocy
         f2SZrf2kaWB7F7kUN0VY6lpjbHga+GsrviP75WGjlZJeMaMORDGU1oP2nxfkEn2lBqY/
         BMB0GmC6AcOC1foESxjAM4FGCjibv1xGHPoUhwiu5/wOHrgbJ1XdhDN+ZiSPB6akIvVb
         j6IQ==
X-Gm-Message-State: ACgBeo205bBOcaTkOEpjMRI5YHj3SQaYor+8QF53D4U1Ow5o2X1hObWM
        A3evHpb2/ArVNZsDNUeDN/c=
X-Google-Smtp-Source: AA6agR6SaPh6TQR2jrGqMuxokjkztVuOb+FBs79oKi9ri7z5vq1qD6tfoTAmHRJ5JuPpurGESx0MTA==
X-Received: by 2002:a17:902:ced2:b0:177:fa1f:4ac4 with SMTP id d18-20020a170902ced200b00177fa1f4ac4mr362135plg.20.1662627805474;
        Thu, 08 Sep 2022 02:03:25 -0700 (PDT)
Received: from localhost ([2406:7400:63:83c4:f166:555c:90a1:a48d])
        by smtp.gmail.com with ESMTPSA id f21-20020a623815000000b0053e99f2bf16sm2136000pfa.78.2022.09.08.02.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:03:24 -0700 (PDT)
Date:   Thu, 8 Sep 2022 14:33:20 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        lczerner@redhat.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 11/13] ext4: factor out ext4_group_desc_init() and
 ext4_group_desc_free()
Message-ID: <20220908090320.tykdh44uhxgimwzf@riteshh-domain>
References: <20220903030156.770313-1-yanaijie@huawei.com>
 <20220903030156.770313-12-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903030156.770313-12-yanaijie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/03 11:01AM, Jason Yan wrote:
> Factor out ext4_group_desc_init() and ext4_group_desc_free(). No
> functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 143 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 84 insertions(+), 59 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 69921a850644..468a958cf414 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4743,9 +4743,89 @@ static int ext4_geometry_check(struct super_block *sb,
>  	return 0;
>  }
>  
> +static void ext4_group_desc_free(struct ext4_sb_info *sbi)
> +{
> +	struct buffer_head **group_desc;
> +	int i;
> +
> +	rcu_read_lock();
> +	group_desc = rcu_dereference(sbi->s_group_desc);
> +	for (i = 0; i < sbi->s_gdb_count; i++)
> +		brelse(group_desc[i]);
> +	kvfree(group_desc);
> +	rcu_read_unlock();
> +}

I thought we could use ext4_group_desc_free() in ext4_put_super() too. 
But I guess in there within the same rcu_read_lock/unlock() we call for 
kvfree of flex_groups as well. 

But this change looks good to me. 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
