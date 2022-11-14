Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DEE62766D
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Nov 2022 08:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbiKNHdr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Nov 2022 02:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbiKNHdq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Nov 2022 02:33:46 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDF5B19
        for <linux-ext4@vger.kernel.org>; Sun, 13 Nov 2022 23:33:45 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id j2so12450345ybb.6
        for <linux-ext4@vger.kernel.org>; Sun, 13 Nov 2022 23:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fuJxEvQ8hWJBVA+YQn5WV9w4flp3A4j0tI4rSSd1Ck=;
        b=fnIJexOrurLq8LJxVcXEJiknMA3dW9UhnBApnJkZZdOQZ7GQAbmzYeMl3RpkpcK9eN
         ssGJDVCSM/G66oN3l/9N080U0aODjMhnMZCqEBJm9ZMYaY6Aggifa5zAaA7tKIRyCrEo
         D2OZ+7x3ZXtx+jsJEQPygmnZzCeWOa6EsxMTsWNehw/8wkeN7nHNiyvKiNOZmL5XCLFG
         sAimVVkazKNjpsa6O+fJ/wFU0daCv/tJgODcigKC8lxyiUaUz4VEamAoi4IarXnImxnh
         5UsDuqaUIs2ZCBqRhz0yMBCcKzxexWPh5f3wCcSGmA524XDXyHtFFowQmf2vo/n/6G+F
         GuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fuJxEvQ8hWJBVA+YQn5WV9w4flp3A4j0tI4rSSd1Ck=;
        b=7LJYehNMkBdkdPX+zyUk+pPmprpZSFVdetROMUM5n71Eamrc49CAjP6VktvOE0rBI6
         u7xykHTsX8NX4eqbdK8NRQXjglHCOvJWq4ro6LKPK/WlovXx/bxrw68uQxPhUen+BRuH
         jsK9G1H+Edg5V5d0uTeNHC15K1d3fdCljY3h4SIJp11hnkE4CUG68ocqztqS0v1T2gA2
         PSWQyHQitHL4RNbdUcRc0y8SgzrmAbmABVF1yrvKvulOu9PM4Ox4FcL1xNDs5vKkDVHK
         9rGvhO529+3bPQ3YJ206vPB8bz+O1GcClmemjuFJy5pxfLu+tKrCqbsferp53Qz3+5L0
         OVuA==
X-Gm-Message-State: ANoB5pmhcAiM8M+TQojwxtQZ/bjfkd6BsfcIHdRMhBiwz//aX4HlTLmc
        jl6zbvrk7KiNaMSFuX+7dfAWO4Y8trds97RgUuY=
X-Google-Smtp-Source: AA0mqf7yCCMH9O+fvwLxmis2Mymu/MG4XZiNMTatfeYXBnL4w5KvOb71VTFOHBPJLX3gOceWwAZkMF+kleiY4/TRE9U=
X-Received: by 2002:a05:6902:118e:b0:6be:92a9:c9a8 with SMTP id
 m14-20020a056902118e00b006be92a9c9a8mr11279033ybu.408.1668411224576; Sun, 13
 Nov 2022 23:33:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:6a91:b0:313:c00e:5dfc with HTTP; Sun, 13 Nov 2022
 23:33:43 -0800 (PST)
Reply-To: seyba_daniel@yahoo.com
From:   Seyba Daniel <abdoulyameogo1234@gmail.com>
Date:   Mon, 14 Nov 2022 08:33:43 +0100
Message-ID: <CAA_gp0f4vhLGTqGEMmgnXVWgdUvK_4i1Q2UA3G-mH2uF_FRAKA@mail.gmail.com>
Subject: Seyba Daniel
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I urgently seek your service to represent me in investing in
your region / country and you will be rewarded for your service without
affecting your present job with very little time invested in it, which you will
be communicated in details upon response.

My dearest regards

Seyba Daniel
