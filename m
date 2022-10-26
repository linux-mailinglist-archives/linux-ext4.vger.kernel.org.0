Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA4C60D8CA
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Oct 2022 03:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiJZBR5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Oct 2022 21:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiJZBR4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Oct 2022 21:17:56 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAD4C2CB5
        for <linux-ext4@vger.kernel.org>; Tue, 25 Oct 2022 18:17:51 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i3so13746028pfc.11
        for <linux-ext4@vger.kernel.org>; Tue, 25 Oct 2022 18:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0R/zuogst9d/iMbwGJahqQyG29x6cKUoOmr+NFwHscw=;
        b=CI1yQ/YQ/tnZzmgve848XpigUhg8RfAlohpGXwTPlL1rtvw+cEuQkOOqNoe4cJ5Nmn
         wOKRSCOiCCIJxQdierMy2Bb+V59SGh4lVxTYrVx6LTmEqWGsLsTEPDReqGvaXHfBZ4sN
         QjhppDIvzcNeXJ+GjtJhhSM5sKqXtbq8P7Iis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0R/zuogst9d/iMbwGJahqQyG29x6cKUoOmr+NFwHscw=;
        b=pJXvN+/RxeIsk6urSx2nGZi+zZOA+QTNbwwhb1f9OqvdtBUZoLD7NElJizS4+Xtea3
         57H4OhEQYy+eIxjXdQ/2UfM3Xz97o2wG3+32l6CuqDqIAow7C4MpQZ90VOHhGobQQQKL
         YhtI873Z6ZGf7+0SlGIEjF4dQEvIt2TxiUVNoUZlpjV21ou+nv+7cVC98yOiuAKDs5ZS
         FQ3JH4YcN3h0Z3mMFvNgL+FWomleCyMp96t+DVlQ+mqWTVhRG6ky3rfhbuPeuqmZvmDZ
         YIW7WUxK2eiHcY4yMUmJGMXaKxct05/UXivQb/pdSit+DCtZ5osRjcNRUgDb3nd0OTXw
         FWpA==
X-Gm-Message-State: ACrzQf2PM9bSFS8RVFdSyHNJLregyLXQvqJGz6TPlnHRw9FimrIEwxBN
        wibS5fET+B8K3tmpwcVT/S1eNw==
X-Google-Smtp-Source: AMsMyM7Xro5ZU7+jhnQa/JNPDsQcNW9Uc99cbnu1rLZvco3Ob13wL1U0NxHdZxNRbtzgHPEN4QT4qQ==
X-Received: by 2002:a05:6a00:348b:b0:56c:35fb:8dab with SMTP id cp11-20020a056a00348b00b0056c35fb8dabmr4070124pfb.13.1666747071125;
        Tue, 25 Oct 2022 18:17:51 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:faf6:e503:6cac:3b53])
        by smtp.gmail.com with ESMTPSA id j18-20020a634a52000000b0042988a04bfdsm1840383pgl.9.2022.10.25.18.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 18:17:50 -0700 (PDT)
Date:   Wed, 26 Oct 2022 10:17:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     wangkailong@jari.cn
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, linkinjeon@kernel.org,
        sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        roman.gushchin@linux.dev, akpm@linux-foundation.org,
        willy@infradead.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org
Subject: Re: [PATCH] ext4: replace ternary operator with min()
Message-ID: <Y1iKuYLba/hingnG@google.com>
References: <5036013e.4.1840fa09d42.Coremail.wangkailong@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5036013e.4.1840fa09d42.Coremail.wangkailong@jari.cn>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On (22/10/25 22:51), wangkailong@jari.cn wrote:
[..]
> @@ -879,7 +879,7 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level)
>  
>  		err = oplock_break_pending(brk_opinfo, req_op_level);
>  		if (err)
> -			return err < 0 ? err : 0;
> +			return min(err, 0);
>  
>  		if (brk_opinfo->open_trunc) {
>  			/*
> @@ -913,7 +913,7 @@ static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level)
>  	} else {
>  		err = oplock_break_pending(brk_opinfo, req_op_level);
>  		if (err)
> -			return err < 0 ? err : 0;
> +			return min(err, 0);

Honestly, I don't know. My personal preference would be to keep it as is.
"return min(err, 0)" is a bit unusually looking code. Just my 2 cents.
