Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5543D73BA1B
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jun 2023 16:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjFWO1f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Jun 2023 10:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjFWO1e (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Jun 2023 10:27:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A612129
        for <linux-ext4@vger.kernel.org>; Fri, 23 Jun 2023 07:27:33 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5539ada6075so115755a12.0
        for <linux-ext4@vger.kernel.org>; Fri, 23 Jun 2023 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687530453; x=1690122453;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTvsQhQg+h/6sjmrvelSIwmDtg13vMLMA+Amro1Li54=;
        b=lXpJzgQNWwfs8mxsJzjqqN7vope1utG4AxzgV1/vHoC6RBwrpSRRPtaRCaLP37tdmi
         797NlhGzETdYlK7zx8zHUhhqrxGCpcZZ5YphrtpNu59sv66LnViLrphqY3FuAcg91JBQ
         8PEUiRIV/xD09ip0RfazefBvmurY0NWzj4L5q/Hi80PA9/gQlqm6wCmUv8IJ/2lPc08C
         9njgSPAm7U5ZL/OWAE7lp3sSgMY55+l8DUnVbgMKl/Kg9XEjJ9r8pmkWPEZU2Yxo/4zy
         rlwgZd3JRYWk/9qwwp2/8mI1qLHVShwVTIQLzAcsbC3PakTOIqEkwg7t+VFYzNdhBARH
         yaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530453; x=1690122453;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTvsQhQg+h/6sjmrvelSIwmDtg13vMLMA+Amro1Li54=;
        b=RqEMRq3dz0TkCEZDxjcWBinNtIiddhsK+z5pM1hk34V2eeLzrykM+wmcc6wNQMWbzu
         ys4+S421kBxhds4tTc4QsUnm50E3i4tDcrd1bVP3VnslegRNjaWASlIJ7GNqu9WDrO0F
         D8lK4ELb9LNgdBDYpx6zh+55OqUGR1UAxIOYdFnmMgpk/P+8nwv4hGY3NDRQpsN0imGd
         qvBIjRzOIwREwsElDwWu4AxSzEg6xfL+L5xCqaUTb3mCDai3PnYuTiKG1fISNbiqdHFf
         hZSf4Nd7EGJgoaid3torhwuH6W4DXzyyCj260Z96Vs7Jh4nXceErzufbr2aeva6E0mNF
         tSfw==
X-Gm-Message-State: AC+VfDwu/kcuE5Qh1QD7MqtuRQB7/BONrtR/0vd8HH4GRH8RTJHw0gSa
        mNJ0+5lmJrDS25AG77wXGBOWuTiIbtjhSjWkM0I=
X-Google-Smtp-Source: ACHHUZ5/OXC0NppqoOq90GmL+bp8zjgBepblkSqpqUTQkpHQCO7r4kHc5KW2EGmCwT/GphvlPCNmjA==
X-Received: by 2002:a17:903:230c:b0:1b2:1f12:acf with SMTP id d12-20020a170903230c00b001b21f120acfmr26082569plh.6.1687530452727;
        Fri, 23 Jun 2023 07:27:32 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id lg13-20020a170902fb8d00b001b3ce619e2esm7291108plb.179.2023.06.23.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:27:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20230622165107.13687-1-jack@suse.cz>
References: <20230622165107.13687-1-jack@suse.cz>
Subject: Re: [PATCH] ext4: Fix warning in blkdev_put()
Message-Id: <168753045157.468611.1058915697772264584.b4-ty@kernel.dk>
Date:   Fri, 23 Jun 2023 08:27:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-d8b83
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Thu, 22 Jun 2023 18:51:07 +0200, Jan Kara wrote:
> ext4_blkdev_remove() passes a wrong holder pointer to blkdev_put() which
> triggers a warning there. Fix it.
> 
> 

Applied, thanks!

[1/1] ext4: Fix warning in blkdev_put()
      commit: a42fb5a75ccc37dfd69aa9bde5ba2866e802ff3c

Best regards,
-- 
Jens Axboe



