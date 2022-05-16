Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8DB527EAC
	for <lists+linux-ext4@lfdr.de>; Mon, 16 May 2022 09:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiEPHgo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 May 2022 03:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241393AbiEPHg3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 May 2022 03:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0516DDE0
        for <linux-ext4@vger.kernel.org>; Mon, 16 May 2022 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652686584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HBr6RsK832/kNhjiBHy048AvZza2SX5/1dw9zvCd9GU=;
        b=HKRwNLZsOOXEe3AKQxiKlksCMAASv2JIRaiH8xsbXo2KIeTQ1QwEdaF99e6fSa0tUl3KOo
        3WrTfszg13RiArw+89O6ackXmHm410JR/v4kRqHPEgfmo5ZIU40sshEaMCU3ZfvBjN67N8
        VwUux17td6g4a70kFMaL5S2akj2JdOs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-G2WsWnUDMvKiskE2BhqAqw-1; Mon, 16 May 2022 03:36:23 -0400
X-MC-Unique: G2WsWnUDMvKiskE2BhqAqw-1
Received: by mail-qk1-f197.google.com with SMTP id z12-20020ae9e60c000000b006a0e769f9caso10061903qkf.5
        for <linux-ext4@vger.kernel.org>; Mon, 16 May 2022 00:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=HBr6RsK832/kNhjiBHy048AvZza2SX5/1dw9zvCd9GU=;
        b=hS0x0TeMF4ooYv41mwT/JrwrgPd8wxKodm7UAFwOfIAo98zQlDDKCHdYgb3CbU3OgH
         DWTINJKguTh6rSf2Mq06ZIqFwoj8Pu1g3/TuARne1FsV9knqd8TGGUWIgkEJt/qp0OcK
         VBn8pGHzTuXnchr2sS4YnQ5j+SjD7JhI4FKyGtsMeXHNABD4xt6Ie2hs9WpXb3tgloZO
         YfzLsnswH/nUD5DDQWDbDTdbLunQtVeJ+ZnK4zQiUsJPndenFmHo1tIjwgdvzKhWK7/6
         q053Pkt/BL42YUGo6/IyAaVtJQYOAPeY94iggY/jdZq5artyF5SHy3XKu49jDXVPBWQO
         nANg==
X-Gm-Message-State: AOAM530xRvqUM+BbChXWJ0cldCUhg2dMYcdbHOsru9Tct9o+EUeikbT3
        YRoLhQWk9g82+RwxplpZ3D5yphgrTu1Ksve+/5yJgb+1zFQVrasGrm7bwJjh8kh9vKtuabCNpAP
        JcuAag/LwgX53ebEnYEG9dw==
X-Received: by 2002:ac8:4e8c:0:b0:2f3:d53a:add3 with SMTP id 12-20020ac84e8c000000b002f3d53aadd3mr14235510qtp.300.1652686583192;
        Mon, 16 May 2022 00:36:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1KfBFNUSFZm0cKhHb5K+b2Dizh0DvtxGYxSxl+tPRDFBtmmgziUdhDE+xynjbHIki+pPA1g==
X-Received: by 2002:ac8:4e8c:0:b0:2f3:d53a:add3 with SMTP id 12-20020ac84e8c000000b002f3d53aadd3mr14235496qtp.300.1652686582917;
        Mon, 16 May 2022 00:36:22 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v6-20020ae9e306000000b0069fc13ce23esm5424130qkf.111.2022.05.16.00.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 00:36:22 -0700 (PDT)
Date:   Mon, 16 May 2022 15:36:16 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     fstests@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] common/rc: Modify _require_batched_discard to improve
 test coverage
Message-ID: <20220516073616.x3sauzctypcxstet@zlang-mailbox>
Mail-Followup-To: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        fstests@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220516063951.87838-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516063951.87838-1-ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 16, 2022 at 12:09:51PM +0530, Ojaswin Mujoo wrote:
> A recent ext4 patch discussed [1] that some devices (eg LVMs) can
> have a discard granularity as big as 42MB which makes it larger
> than the group size of ext4 FS with 1k BS.  This causes the FITRIM
> IOCTL to fail.
> 
> This case was not correctly handled by this test since
> "_require_batched_discard" incorrectly interpreted the FITRIM
> failure as SCRATCH_DEV not supporting the IOCTL. This caused the test
> to report "not run" instead of "failed" in case of large discard granularity.
> 
> Fix "_require_batched_discard" to use a more accurate method
> to determine if discard is supported.
> 
> [1] commit 173b6e383d2
>     ext4: avoid trim error on fs with small groups
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
> 
> Changes since v1 [1] 
> 
> *  Changed $RET to a local variable
> *  Fixed the grep command 
> 
> [1]
> https://lore.kernel.org/all/20220401055713.634842-1-ojaswin@linux.ibm.com/
> 
>  common/rc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index e2d3d72a..f366e409 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3858,7 +3858,13 @@ _require_batched_discard()
>  		exit 1
>  	fi
>  	_require_fstrim
> -	$FSTRIM_PROG $1 > /dev/null 2>&1 || _notrun "FITRIM not supported on $1"
> +
> +	grep -q "not supported" <($FSTRIM_PROG $1 2>&1)
> +	local ret=$?
> +	if [ "$ret" = "0" ]

Oh I forgot to ask why we need to add a variable (ret), to record the return
value at here. Why can't use "$?" directly? e.g.

  grep -q "not supported" <($FSTRIM_PROG $1 2>&1)
  if [ $? -eq 0 ]

Others look good to me.

Thanks,
Zorro

> +	then
> +		_notrun "FITRIM not supported on $1"
> +	fi
>  }
>  
>  _require_dumpe2fs()
> -- 
> 2.27.0
> 

