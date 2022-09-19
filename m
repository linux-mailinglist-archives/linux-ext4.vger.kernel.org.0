Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7315BC2BF
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Sep 2022 08:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiISGRY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Sep 2022 02:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiISGRX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Sep 2022 02:17:23 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CD51C105
        for <linux-ext4@vger.kernel.org>; Sun, 18 Sep 2022 23:17:22 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id u6-20020a056830118600b006595e8f9f3fso6967772otq.1
        for <linux-ext4@vger.kernel.org>; Sun, 18 Sep 2022 23:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=gUUMSU28Fu4gDp5OjTJUAIjagHf+OPIeTerfpporP3o=;
        b=lzm8EwmNkc/OTkoc1A6ZZMzIy7Ae0k2o6ZfSwqLjoku+wqEcJwvY42DLrU4Y20l8kW
         hFKd33tvY6uqMRdqFPBqVxQJB6KZl8iFrOPKX4lauSqwBYka1uCtjTIA7x1KIKKZD9wy
         DseMg3jIyRI49jSqPSCmimIrrqBY+liZ0r6VBm+VkSKownpKNrvPtUzLy1IRVyaCe+/m
         j3efo0GE9G8GDUy9MoQSGmBIekJ6QIwLgjeDUSfadQXvZQswQrx9f7dUXgxEomNJsFbv
         otGLH1K4EvG4A2JH1DWPoxHg7a2RsW44XMd6uZUwJ/+VIrzg3c9SXv7b1GisH6EMtNuS
         M9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gUUMSU28Fu4gDp5OjTJUAIjagHf+OPIeTerfpporP3o=;
        b=gVq5DEPhbcTiDd1jiUqy1E3ALBttolMG4owSw/ZboTjGZoIAqaVhwUZKv25xIYzbVm
         tWhVIy0TYCA9QrBCHa3uE+HkzEvYDNXF3TgzfWzphdZ35ROGABpUlQ8wGNwbl1trVD+7
         9El8FIiP0YPkz4SgcR8g3WquR+js7izETawBG9jT3L3ymMlpPcqrCapjov1BWpGwV6cd
         ST07okopm7rIew6A6TllSu/mdYxGFml+HzRI3nNojoxc85vin6Reek5GPaKTQOu4MlAE
         sLcUDhcNoqXxix7qT6aSI1n9X7C4SE03BURKDozAgLvUg2RedYBHflNjyOdj9ucVGfx+
         LC6w==
X-Gm-Message-State: ACrzQf3YfO/iAUVSSRtOv3EREpzY1gQq71/1omzLB8stAjiR8N+9R+OX
        5CVKPJofDyvfoQyZtHIrUKRdIuDU1EdlKVCaEOI=
X-Google-Smtp-Source: AMsMyM7ycpumkREIGx4PJLnztdXVSgO5/3IceKIAjS2G3DLkdTzL2f9gtMv6oav4trCPnwicVeW+w4JD8cq8snaSeWo=
X-Received: by 2002:a05:6830:1cc2:b0:636:85b5:bb62 with SMTP id
 p2-20020a0568301cc200b0063685b5bb62mr7261060otg.115.1663568241688; Sun, 18
 Sep 2022 23:17:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:5b82:0:0:0:0:0 with HTTP; Sun, 18 Sep 2022 23:17:21
 -0700 (PDT)
Reply-To: garryfoundation2022@gmail.com
From:   Garry Myles <mohammedrakiyat06@gmail.com>
Date:   Mon, 19 Sep 2022 07:17:21 +0100
Message-ID: <CAF4H7+EgV1DNeyiu1Mv3o1z8LyZZVTbGE3FLLKoK3N6S_WvHjA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7853]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mohammedrakiyat06[at]gmail.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:344 listed in]
        [list.dnswl.org]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [garryfoundation2022[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mohammedrakiyat06[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--=20
Hallo, lieber Beg=C3=BCnstigter
Sie haben eine Spende von 2.000.000,00 =E2=82=AC von der GARRY CHARITY FOUN=
DATION.
Bitte kontaktieren Sie uns unter: garryfoundation2022@gmail.com, um
weitere Informationen zur Beantragung dieser Spende zu erhalten.

Dein
Garry Myles
