Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7CF5EAF49
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Sep 2022 20:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiIZSK5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Sep 2022 14:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiIZSK3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Sep 2022 14:10:29 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB7D322
        for <linux-ext4@vger.kernel.org>; Mon, 26 Sep 2022 10:56:36 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-350cb1c0abaso39593077b3.9
        for <linux-ext4@vger.kernel.org>; Mon, 26 Sep 2022 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=C237qwozOvl8aPF+8xhmIlNpmWxUmRobeuzg2CJNr44=;
        b=U9hwiLfYludCtXf+u0nsabYBP7stdr7yW99wIfiKPEhqMHuuQX6od3d2kHzQbh22li
         U/zTa1UeDa99ukJG6xtOrZn0LBmGQXcx5OW/YCV9ONG7IC0HDs24sEhnFeKotoq2a0mE
         OyMgLs0LpFpwtmy8snEODDWoFj9tCQkCc+YtGWJzTA6qetH5qBICh+sDbGFahSo7jzDB
         T4xdvWGGdej4b7MLGPvCIhDgZDk5+CsajAyU9jKjdUUSAigMdAqtODPI8KwwhJbr7+7U
         3parV/TeNWqYg5AxN+caSJ0MAv04AKY4P/Rsi7JvXzlChyB2mYdJqzGKo3aZ5yvTETvs
         yA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=C237qwozOvl8aPF+8xhmIlNpmWxUmRobeuzg2CJNr44=;
        b=lNaMFYZkxBqkcRjlh5JVieqGbgFRA2ePcPfCf/vtiZbcMcp0d+73M9E2EJrPUmgO0S
         iPoe7CfrlH0mbDD5OCvcTGKME/T+ofWlVbQedYwCz4YJAeKMzsiZqmoWheTPADBYwK6H
         B9QsLr6uf4YvGScUl6rAbuStSHU9U+AwZMHzMuycXNaBs775ZYXDAK/DX+FUji4BVZE1
         S20vkcpxrA3Dh2ZIYeMtyaIvfL6Kr34dryCEH1wCt6K/XbKNfhJauoHX/souMvAGe8Q0
         cJG4rVlDUq2QFcr1K63E1x+4tiyS5BpPAU1Sgv0tB4enTXUdH4EAlNtex1opoADQ+pzJ
         48ZQ==
X-Gm-Message-State: ACrzQf3wLZnob7xf9Hy+9wfOPoEn69pZS9+iqOVBlMVXTFZ/9hz64TOI
        mGDCz2nIqalR36dAZovsHiHzeoQqy3el07JT1OE=
X-Google-Smtp-Source: AMsMyM4DtELNq3UfC6ogqw6JJnpKyAYcDqudvgTz/Cf2F94+yabovEqZ4sg5zE+TIZdy1rLTqMtQ9t3eTSSycA0RlkI=
X-Received: by 2002:a81:7955:0:b0:349:e6a4:7960 with SMTP id
 u82-20020a817955000000b00349e6a47960mr22130363ywc.74.1664214992399; Mon, 26
 Sep 2022 10:56:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:7150:0:0:0:0 with HTTP; Mon, 26 Sep 2022 10:56:31
 -0700 (PDT)
Reply-To: pointerscott009@gmail.com
From:   Abdulkareem Ademola <adeomoade123g@gmail.com>
Date:   Mon, 26 Sep 2022 18:56:31 +0100
Message-ID: <CALzsaxtqUL3ixWqHqjkdPSYn1rM2gkh46kq-VCD+Grzcb7UU=w@mail.gmail.com>
Subject: =?UTF-8?Q?Bussines_offer_Gesch=C3=A4ftsangebot=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1130 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7310]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [pointerscott009[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [adeomoade123g[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--=20

Hello, Do you have a projects that need urgent loan??
Granting out loans today in 10,000 / 500 Million to Interested
Investors, Companies & Private Individuals.
Revert back if you interested.


Hallo, haben Sie Projekte, die dringend einen Kredit ben=C3=B6tigen?
Vergeben Sie heute Kredite in H=C3=B6he von 10.000 / 500 Millionen an
interessierte Investoren, Unternehmen und Privatpersonen.
Kommen Sie zur=C3=BCck, wenn Sie interessiert sind.
