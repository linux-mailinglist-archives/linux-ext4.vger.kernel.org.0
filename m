Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89135878EF
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 10:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiHBIWj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Aug 2022 04:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiHBIWi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Aug 2022 04:22:38 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6D3335
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 01:22:34 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id 125so13787825vsx.7
        for <linux-ext4@vger.kernel.org>; Tue, 02 Aug 2022 01:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=bzng0CUaoRLDRRrx91GJcqXUs4JOfIJWU/22IW5Wrvg=;
        b=BAc7fra6fzfPFWFichPXhygEeRbzkGxhtahUMeLGunEYw5pwZFIO2IXl/ymiBQYDZy
         HIs3SR3VlJ50X6QIhrUPrJg8h5Tq/vXhSgFvt73WvoortlshhN57HAAZ/4MH/Wdqyg4o
         LRno1s5Y9Vi7C8nZJ4K9X6k0NwtEc5d6sxlXXUvYrqkLx4iqOw/iWIH0ngD9KC51KYiy
         6NoJTJqHJ1XwV+J1GwPDOWCwxy3hRGdxjSqKm3KVK+A6l1SzBjjMgPi+lQhGNBzJijQP
         R8QgVOMewGl5zy3HZKWE0kGmk0PiaT+JL9oSbGzLBK6Y4hsEjTngeXuxAWkta7k5eJBg
         yoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=bzng0CUaoRLDRRrx91GJcqXUs4JOfIJWU/22IW5Wrvg=;
        b=fDGVsuV73PebXMwcC3E6/I0NYy8k+zERCS/5d+wbWIPs84A8jmCvViCc/cZ4vJK6Zh
         i/360Y3+4CSQMsDYwJPLxSV9RUcN6USrtA2d3RF30aCo7AHGK/l5o2qksPxCXo/U+O56
         FqbEMjGQWC4hzs4/5WJiJqm9UoqjBL1OTckc0Q1mB/3LdAYYg4n5u1J8HNnwgMDtUTeD
         BFoY4s6glKdW+zbjtZrcKaC6RR+Grem06F549sDDS3WoVX6Sk5mtxLxCDq1Bgbe3kWpK
         0PnWoq483ek824rBHDhaRBEPJDCdUkgkHdmYmgn+6anO9W6NXZI2cvgi9Q94bBJN16m3
         MIAw==
X-Gm-Message-State: ACgBeo3iwVvI6JwOsngCY+EiY+PDHV5DgOe3KYjyNxWVFklS0hKqRclo
        21uGcNyws2isrrUYSJHybFVLVUiLt3bBqqmozw3tr94hCk7KiQ==
X-Google-Smtp-Source: AA6agR7v4amGDH7ucOktO4jLGJllSevBvENC4f4pY5h+S6sBU4/3fNhKP+h2OzDlX7oGZ3hCi7k0VEBd14GG8uyr+do=
X-Received: by 2002:a67:e24f:0:b0:386:64aa:810 with SMTP id
 w15-20020a67e24f000000b0038664aa0810mr2750488vse.13.1659428552707; Tue, 02
 Aug 2022 01:22:32 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Ng <danielng@google.com>
Date:   Tue, 2 Aug 2022 18:21:56 +1000
Message-ID: <CANFuW3eGgyeWba-2GjDtdhYvX2fV7-dcrHn-4O8QAeHDERAbqw@mail.gmail.com>
Subject: [BUG] fsck unable to resolve filenames that include '='
To:     linux-ext4@vger.kernel.org
Cc:     Sarthak Kukreti <sarthakkukreti@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I've run into an issue when trying to use fsck with an ext4 image when
it has '=' in its name.

Repro steps:
1. fallocate -l 1G test=.img
2. mkfs.ext4 test=.img
3. fsck test=.img

Response:
'fsck.ext4: Unable to resolve '<path>/test=.img'

Expected:
fsck to do it's thing.

Observations:
Originally I wasn't sure what the source was, I thought that maybe
mkfs wasn't creating the image appropriately.
However, I've tried:
- renaming the image
- creating a hard-link to the image

Running fsck on either the renamed image, or the hard-link, works as expected.

Kernel version: Linux version 4.19.251-13516-ga0bcf8d80077
Environment: Running on a Chromebook

Kind regards,
Daniel
