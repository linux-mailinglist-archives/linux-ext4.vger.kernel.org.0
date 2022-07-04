Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A68565EA2
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Jul 2022 22:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiGDUsU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Jul 2022 16:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGDUsT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Jul 2022 16:48:19 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7E72630
        for <linux-ext4@vger.kernel.org>; Mon,  4 Jul 2022 13:48:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id r1so9375592plo.10
        for <linux-ext4@vger.kernel.org>; Mon, 04 Jul 2022 13:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=p+Dd7tq+qCE50jZX3vv9qGsNiRpXQ5axQnaZC7MQ694=;
        b=JtlOJ9VERG7PZII3mMrUUe9Vk75Y4jPb1TqJgYWCrrIds0eAuCSSxOv77t9iL3DGz2
         ppAh4LsWaltVKLsynhTQoz1cde1ngc/jXKfRSREWudi5oMMk/0oselDtlTXoZtvtLb4u
         bEfO281i8SJsmhwft0uPnQS/kKnyAFHU0jjz+Q8vl+U34yn8o2fvsmlLmSAgGYxMU5EJ
         R5xcDlnrYs2KqGcAsRMmAldvvRwuo1vLl7YaW2YP/XfKykIDdgx10BZLW6T64SRK3Niy
         JuDbW55tUypMH5WvtEkMhJX3Smmx3ZBpUbMB/gE5S02iRW4n10BXLV9OQiW8mL0UE4PV
         NuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=p+Dd7tq+qCE50jZX3vv9qGsNiRpXQ5axQnaZC7MQ694=;
        b=jGgjZ0/jFPhJ2wIgj6CIylFs9qRQx7vBFIQg0f8XLbTuL8PP09mQw6psBT12LuSWbJ
         kf+TD+Vcnen7FktJYUsXZKkiD9cPRy6GjojR8+6cm7Y4q6fc+0Zte4hQDsySrcrLbNs/
         +XTTZueMo5zG3KZJSiT6cT/OFrRkSL9TsdUMxgdxSmV1FDNiZ/wGHQF87Lktkkbzv9MA
         ZVP0uWz6nylUccOZJ+grUh7Xxd4w0hMOQm8vtsJjggjL+N4DZPp6saChUoL85ShrbDNd
         kdb9TZifuzxraB4DnmTpgobm04y7rXXWG2TKfoV2eknmXWU89W5w1bEtVGqhF0JWuaEZ
         l6Iw==
X-Gm-Message-State: AJIora8a3bvW+m5Jwc83qyL3Re4TVb4GtDEH0KeOims4x83J5A7vnHG1
        2cU+p8LYdl3PVDWi/fQtKErdRmyybMnCCVH8
X-Google-Smtp-Source: AGRyM1vEbFQd65gH1EOciX3/t2YAh02XnccvB3vvdT/ujgW2FrFALXc5cfGaQkQxbVS98mKWo5kQBQ==
X-Received: by 2002:a17:903:124f:b0:16b:8167:e34e with SMTP id u15-20020a170903124f00b0016b8167e34emr38213660plh.52.1656967698262;
        Mon, 04 Jul 2022 13:48:18 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 64-20020a621843000000b0052861251f3fsm3086432pfy.41.2022.07.04.13.48.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jul 2022 13:48:17 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <68DC6315-7940-48F8-99D9-D26599819EE3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_45E77CA0-91F7-4F4E-95BF-1E9803F73887";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] ext4: update the s_overhead_clusters in the backup
 sb's when resizing
Date:   Mon, 4 Jul 2022 14:50:47 -0600
In-Reply-To: <20220629040026.112371-2-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
References: <20220629040026.112371-1-tytso@mit.edu>
 <20220629040026.112371-2-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_45E77CA0-91F7-4F4E-95BF-1E9803F73887
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jun 28, 2022, at 10:00 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> 
> When the EXT4_IOC_RESIZE_FS ioctl is complete, update the backup
> superblocks.  We don't do this for the old-style resize ioctls since
> they are quite ancient, and only used by very old versions of
> resize2fs --- and we don't want to update the backup superblocks every
> time EXT4_IOC_GROUP_ADD is called, since it might get called a lot.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

One minor style nit below, but you can take it or leave it...

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index e5c2713aa11a..8abff9400f69 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -97,10 +97,14 @@ int ext4_resize_begin(struct super_block *sb)
> 	return ret;
> }
> 
> -void ext4_resize_end(struct super_block *sb)
> +int ext4_resize_end(struct super_block *sb, bool update_backups)
> {
> 	clear_bit_unlock(EXT4_FLAGS_RESIZING, &EXT4_SB(sb)->s_ext4_flags);
> 	smp_mb__after_atomic();
> +	if (update_backups)
> +		return ext4_update_overhead(sb, true);
> +	else
> +		return 0;

(style) no need for "else" after return.

Cheers, Andreas






--Apple-Mail=_45E77CA0-91F7-4F4E-95BF-1E9803F73887
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmLDUqcACgkQcqXauRfM
H+AMkw//UjkXaZ0SBvm7VwQVgfHoqd5YsbX7uCJGKEUcYKtgdZ99jETVNXNQkvEi
xpCLeTh3QorS5+gSOOflcRoPgyW6QAOVKECR58QnxZ6xMpTP1xPd0FAQ5MyZ5r55
G/5h+/TW2/nw4gdAYOVgFLrno78a96XNCH+hHsWBh+LtDbyab9yJPqTJ+/9uk1Li
sHV1oInSAZUDPhcQkh/fhjZg4gLkXHULoXw8KuQko9hgR0ykWLfim8J6j3e4FVnE
DXeVUaXFvoWoWpo6U2rgwTzZolQ13x1NRDry9R8bG80uqDfPqv/GtLVq543Ciikw
/jBjcGLqpljnzpkaNmizj64KY7H+3HsERAUXkNiPYNEV6YLY4v1fe3i9DrBvWQDL
NT0GO9v2AM0CjhOqJnAW5oPO/9iJhtTzBnd39nvzGJXhVOh2ekhL/baiESDRSS/9
5dlE9FestHaYoYUCMdRBopeA5mrOT+YovJ4aXhxb+sjzF0pZ+EVbusHgi9nviGAm
LpxOx5yfBJqihecn+JgZomI/uMTX6aoAR71E/DwjAIq2UyFOnKp/RUUk6GTlotzU
KAg2/jIVbQcBuzjvNHWfdwaS4zBjZ1cozMw63hNYxl2BLbEoq44jXsk6CFwJOCJK
hMoCxvIUM0CcASJuOhW6nn1SXodH5GWBVvgNcfac/YNw81j+eOQ=
=dFdP
-----END PGP SIGNATURE-----

--Apple-Mail=_45E77CA0-91F7-4F4E-95BF-1E9803F73887--
