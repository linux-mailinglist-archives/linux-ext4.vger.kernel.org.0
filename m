Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C5323C4CF
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Aug 2020 06:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgHEEyj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Aug 2020 00:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHEEyh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Aug 2020 00:54:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82430C06174A
        for <linux-ext4@vger.kernel.org>; Tue,  4 Aug 2020 21:54:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q17so24555274pls.9
        for <linux-ext4@vger.kernel.org>; Tue, 04 Aug 2020 21:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Xlm55jeOSDuk2ULIFg0fINvYgkZ3lYeM34B/xV63HzM=;
        b=tAuUoEaysZklJetzaU1Vwg6NZW/EJ6R6OQjwA92BHUJwjI0RVeUoj1uhflfVyYA6Vw
         2FslpU/ABY3fTROHyvuGVMg4XS0x6x7PVOlQ0w9Ow0DeOL11QweUdcwrW1touam5N+MD
         X8znEXJDqWLlc5gybkCYq5NNFIzG7JDkHImT9x56DulAOAlnsVXmI1gWeM6G2K18WILK
         Zpvhl/11njMe9pQzRAdscSuyrqUc3T3UbrXY986oS/zLPd/h3C15MQf221uG8v9UT7BS
         kHuTprAWIZn1wHxB9UsiqcMx2RhJLGHUjEnlP81PEgbZdru13Lw/+hEYJ+OHbobjWh0x
         83eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Xlm55jeOSDuk2ULIFg0fINvYgkZ3lYeM34B/xV63HzM=;
        b=sdKV9klc6WpCLHWN81alnBKK1nt/6BY1QCmpI1tcZNUmEjjtMq2aGuGMwT9nVBRgqM
         qaPbMp4iG4sDkpWZXlxS8IGEoI7QKOX4jBgDeS+5fNtCXMhz2/HUXVZDRq1j1pUpGumW
         AW2jvXrIy78iP4hR8y3bkRV2e8RK7A074tA88ye5SfD72pfEgs4cJsJEBFS3K7epXJPm
         I1QIthnsM1luZV99xQ24pd/5PZqjMeamE4grkuSoTfLw1zjrwScFTIFkLHU68e+SrkKa
         3grH1FHGyYIrMMT18++TKczKY7M6qfPb//DBkPhoIHvm0zWpf8cQPknGWqXX1Z4IdYuJ
         iBew==
X-Gm-Message-State: AOAM530LKO9WLgc8NCwEIO8FZEASdj9bPSADKOua8LkHX1DN+ieJsZc1
        cO2TUDiRiS8ksKmeYRqkSmHqpg==
X-Google-Smtp-Source: ABdhPJzNfrF0Gw3cgzeyydYgKMo606yNRwzXmJN9mmtEJEiXeGtYBaess4JfH8nlewQBdTDiYsaATA==
X-Received: by 2002:a17:90a:d34b:: with SMTP id i11mr1474703pjx.125.1596603277114;
        Tue, 04 Aug 2020 21:54:37 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id s185sm1309641pgc.18.2020.08.04.21.54.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 21:54:36 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <18DB2B7A-FAFE-4DD8-BD5D-85873F9ECC54@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_86DAD2D5-2ABE-4847-8768-9DE5BB8B358E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 3/3] ext4: add needed paramter to
 ext4_mb_discard_preallocations trace
Date:   Tue, 4 Aug 2020 22:54:34 -0600
In-Reply-To: <34718b7d-9e0c-e8a9-cdef-9150fc5edab8@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
References: <34718b7d-9e0c-e8a9-cdef-9150fc5edab8@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_86DAD2D5-2ABE-4847-8768-9DE5BB8B358E
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Aug 4, 2020, at 7:02 PM, brookxu <brookxu.cn@gmail.com> wrote:
> 
> Add the needed value to ext4_mb_discard_preallocations trace, so
> we can more easily observe the requested number of trim.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

IMHO, this should be part of the previous patch that is changing the
API for ext4_discard_preallocations().

Cheers, Andreas

> ---
>  include/trace/events/ext4.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index cc41d69..61736d8 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -746,24 +746,26 @@
>  );
> 
>  TRACE_EVENT(ext4_discard_preallocations,
> -    TP_PROTO(struct inode *inode),
> +    TP_PROTO(struct inode *inode, unsigned int needed),
> 
> -    TP_ARGS(inode),
> +    TP_ARGS(inode, needed),
> 
>      TP_STRUCT__entry(
> -        __field(    dev_t,    dev            )
> -        __field(    ino_t,    ino            )
> +        __field(    dev_t,        dev        )
> +        __field(    ino_t,        ino        )
> +        __field(    unsigned int,    needed        )
> 
>      ),
> 
>      TP_fast_assign(
>          __entry->dev    = inode->i_sb->s_dev;
>          __entry->ino    = inode->i_ino;
> +        __entry->needed    = needed;
>      ),
> 
> -    TP_printk("dev %d,%d ino %lu",
> +    TP_printk("dev %d,%d ino %lu needed %u",
>            MAJOR(__entry->dev), MINOR(__entry->dev),
> -          (unsigned long) __entry->ino)
> +          (unsigned long) __entry->ino, __entry->needed)
>  );
> 
>  TRACE_EVENT(ext4_mb_discard_preallocations,
> 
> --
> 1.8.3.1
> 


Cheers, Andreas






--Apple-Mail=_86DAD2D5-2ABE-4847-8768-9DE5BB8B358E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8qO4oACgkQcqXauRfM
H+CzQg/9HDu9bJiE4/wjypv3xhyzKKt2aIyS9AEiDs2K3RwEYH3DwD7RBEicO3F3
AtCN3QOYM2qQSikgnOr8UfaafdjZkpdWFFXbRk73+/9vrphLu2dpO1EuFTI1r0Zr
DzbVHv9AVEqC0Vc+GCGq/YOGFwMf/criysdR8PHkJL95Izx3AcZF3fjaIgWdHKFZ
DcZX2ZQzJjOtpsDfNCTKXA9y7asXEeGERCNbsHCctWOT9dM5uym6b37WqK5XTyPT
XUFy3UxV0KznVzDWOhv2szIf+3gYo3lidDr23ay8662ofWZPRvgMlTcJQEDt1UZK
MDBvPWJbKPAK417KjBsBUlgGwwMqstGR5pAa+YT15hzW6zjqWJBuZBThcAKyf9eA
lmbua7NlQEjsPcpAJkiPzf2dXs07GA+E9vkPxZC23hq/6mUfGq807MsfoxbaLJ9r
t+ejQOjeOszMYc8bt5DG6hTvTbe/NPf+lhONSFq7RxSQMekT+XcuKae1ib3mFfge
I+GWAZgjfBMMfV0rFKVXKUN23H4VbdkcmmvUKDlUy3T2+1+XjaxL/uTD8UPIjvs0
GnN5giqf8hs+5Uyb6LvBiOQ0W/odzAC1aWi96Qh+nwwLTAeKkDZQWV0UiNKsNOy5
MqkJmS5vkqlk0JJCpkagZRM0hFzD9oi3zW++CcEiGUupM23yKH4=
=GAzt
-----END PGP SIGNATURE-----

--Apple-Mail=_86DAD2D5-2ABE-4847-8768-9DE5BB8B358E--
