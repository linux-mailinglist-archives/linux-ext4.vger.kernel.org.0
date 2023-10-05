Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D607BA6B5
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Oct 2023 18:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjJEQlI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Oct 2023 12:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbjJEQj3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Oct 2023 12:39:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A5E10DF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Oct 2023 09:23:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so10552125e9.3
        for <linux-ext4@vger.kernel.org>; Thu, 05 Oct 2023 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696522989; x=1697127789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:message-id:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfUgXm8WtiN9n4E0h6wqoM8FToFDrm/O9XMqk3D6xr0=;
        b=kKBQ9uMuXMEiBGWgdqnaVXDFlQax8zjPX1DF/SUzbe/IrZSwt1ZoTSrlZiTWaV1UyP
         UOW6YxmVRq+lHlq2Tc4S67kB5A6MGlI0bp/zvhctzvjFcrIq8+JATd91Ba7IXp2AvJN7
         1qMrzpaO/6ckomadJjJmYej+Py6gqHZ5xFOiFSRJak0NEEqQuw+t3cHZMjbozgw2Imlg
         Bsac7yo12Agw3JCMRnkk4iOyVLSxHMGNhVX0Xc/75OuiDj18BbvKy1nNXvP4hAIC0HvE
         J5mWE1oLDNL76biuD9008Kh8F+fV++jo2a7Iv/j9MhZGByCPloCD+ojmjWO2Lk3PH3YN
         PsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696522989; x=1697127789;
        h=content-transfer-encoding:mime-version:subject:message-id:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfUgXm8WtiN9n4E0h6wqoM8FToFDrm/O9XMqk3D6xr0=;
        b=vE/tWrCGXf+BOSeiqSlYUS1J2Th6eObd4JkC9t58otBTh7vw2ZkzykmjpWTErlvzI0
         nPn8ggZ0jiv7up4Iq4fuJqG65VAa4+J6xUPaGF6dCsFoK2QpiX8JRBiMkJ6ECARHM6iu
         Tn+fmA0qABWo/rU2WbkRmlW6vsAizf/ytJ735Ycv1ZCbrI6l3ZvQ48XwvWZkNZLmV7fs
         fI5FG7XLyID9E212AZ2BoX1CAh3p9xYD2QzijjBdeIecjGralnmvcHGI2Q7feETc/WjQ
         g+QCRtupdY98mHjl7IcXs0z92tL/z7SFJ8K1flORGteG6BM3U6OqhgY7u1TJtEjUIDYx
         8IbQ==
X-Gm-Message-State: AOJu0Ywp98CzMx9NR/coADoW6T7P7v9p7XtdlfhK79cLGwlMQANykYd/
        h9cwAbeVx7WD8v3bsnU632XAhZTnG5g=
X-Google-Smtp-Source: AGHT+IFYBPrBqITdQ417y3RQ/jBYHLuQZdkiupUBDrQcwGJYV6WrDFUztCp9lATM+2ZRtZb+7HhOeg==
X-Received: by 2002:a7b:c8c8:0:b0:401:906b:7e9d with SMTP id f8-20020a7bc8c8000000b00401906b7e9dmr5275570wml.18.1696522988790;
        Thu, 05 Oct 2023 09:23:08 -0700 (PDT)
Received: from [127.0.0.1] (host86-186-242-217.range86-186.btcentralplus.com. [86.186.242.217])
        by smtp.gmail.com with ESMTPSA id z14-20020a056000110e00b003232380ffd7sm2120046wrw.102.2023.10.05.09.23.08
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 09:23:08 -0700 (PDT)
Date:   Thu, 5 Oct 2023 17:23:08 +0100 (GMT+01:00)
From:   Serdar Sanli <mserdarsanli@gmail.com>
To:     linux-ext4@vger.kernel.org
Message-ID: <fe6455bd-3b1f-4821-ba14-ea189926af5e@gmail.com>
Subject: Documentation wrong? "The number of block groups is the size of the
 device divided by the size of a block group."
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <fe6455bd-3b1f-4821-ba14-ea189926af5e@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

In the ext4 documentation here=C2=A0https://www.kernel.org/doc/html/latest/=
filesystems/ext4/overview.html it says:

> The number of block groups is the size of the device divided by the size =
of a block group.

Though when the device size is not a multiple of block group size, there is=
 another group for the remaining part?

Can someone please clarify?

Thanks.
