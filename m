Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F73C4D04B6
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Mar 2022 17:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244362AbiCGQ5X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Mar 2022 11:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiCGQ5W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Mar 2022 11:57:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62AFF7E0A4
        for <linux-ext4@vger.kernel.org>; Mon,  7 Mar 2022 08:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646672187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKvX1sl7p58ECEtwztu/8ZgveUC73k+ES14SIrLarpQ=;
        b=eA8BHRsaBl1CBRisaXrIJOluFFLgl7mvVmqgUGwhUNZjdNSOT8paZzDxRW0m0gBKnnz8Fb
        M0jFlOHeCLX87qcxtLIex9QZgfsrpMMgemNkbUXbDrpMtW4dlClOq9wl1HZSVELdxwmyQT
        543dR55uEnhfuydgDkOfBMkloeW8RSY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-x7va_vfgOEuokceeuBvhYg-1; Mon, 07 Mar 2022 11:56:26 -0500
X-MC-Unique: x7va_vfgOEuokceeuBvhYg-1
Received: by mail-qt1-f197.google.com with SMTP id ay12-20020a05622a228c00b002e0659131baso3456404qtb.11
        for <linux-ext4@vger.kernel.org>; Mon, 07 Mar 2022 08:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GKvX1sl7p58ECEtwztu/8ZgveUC73k+ES14SIrLarpQ=;
        b=gMHR9joY/Tlr96BEL4RHlEnEdyHscKuzSfRMo+F3maRy2NoSn46i82wOTNYOxmO27F
         4dTk+Qs8cy/lb9e3ghMeCCT2wemwaXOhxnHQwt95GXlRPBmyM/IYaOkOAhh/XpzyRvac
         5p20s35uiA7+8kd7TnSz1M5N+237yzCiwfFw88MTG/vOy92PeoEmTuSoRTro1Hi5m/ce
         u9ILl1tKnKjQtEIzi6aPSO71NHwBsvJIAZcGvcHa8uJJQlD7NKYL7GEL7BPbVQQjRKUp
         90TCS0iKGaNJCnrVCDAXp6z67GjtzxXz7ziqWv2dCUljKvikiDHmR7x/xBO9i38hQaxM
         NC1g==
X-Gm-Message-State: AOAM533TjFV9Z8M8Xdvxdr6k4qNkdypWyAoZfG1Ka2U+BkncdavdGprq
        X5TxqewWVL59xldxpP5R3Xibz8PSr6wuwjnnNPTmOV/lW5yPPhOZXhkUFsdgn0XC5gt99zI8z3d
        fQqtMQRiYxbz5dOKwYQbX
X-Received: by 2002:a37:e303:0:b0:47b:b0e1:fc3f with SMTP id y3-20020a37e303000000b0047bb0e1fc3fmr7411356qki.108.1646672185821;
        Mon, 07 Mar 2022 08:56:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgimeaJmCviuje97Vzy/Bu8ddKoAbj4Lj2WFLdHhsuRx8YeCO+5ZEp3hBleQ9OYyyKUFJxWg==
X-Received: by 2002:a37:e303:0:b0:47b:b0e1:fc3f with SMTP id y3-20020a37e303000000b0047bb0e1fc3fmr7411341qki.108.1646672185573;
        Mon, 07 Mar 2022 08:56:25 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id l19-20020a05622a175300b002de935a94c9sm9086902qtk.8.2022.03.07.08.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 08:56:25 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:56:24 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-raid@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Song Liu <song@kernel.org>
Subject: Re: remove bio_devname
Message-ID: <YiY5OLhi1WMFUgGH@redhat.com>
References: <20220304180105.409765-1-hch@lst.de>
 <164666057398.15541.7415780807920631127.b4-ty@kernel.dk>
 <YiY2wUVIz3NXIjlc@redhat.com>
 <20220307164814.GA12591@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307164814.GA12591@lst.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 07 2022 at 11:48P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Mar 07, 2022 at 11:45:53AM -0500, Mike Snitzer wrote:
> > Should those go through block too? Or is there no plan to remove
> > bdevname()?
> 
> My preference would be:  do the full bio_devname removal through Jens'
> tree and you keep the bvdevname removal.  I hope bdevname will go away
> as well, but certainly not in this merge window.

OK, sounds good. Thanks

