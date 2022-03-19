Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD79F4DEA61
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Mar 2022 20:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244004AbiCST2I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 19 Mar 2022 15:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbiCST2I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 19 Mar 2022 15:28:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11951247805
        for <linux-ext4@vger.kernel.org>; Sat, 19 Mar 2022 12:26:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id u16so14805154wru.4
        for <linux-ext4@vger.kernel.org>; Sat, 19 Mar 2022 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=VnZAL0nBQUXclvhfgZG2Q/nAtL18/vmGeJE/PdQ+6So=;
        b=p84N755DEkiqgR9NRXSZo4r9Slx7Kga+N/c1swI+3tautLwS+eqUip/xgxFf50VgUN
         TFPqHHHpFbYKM/CJ+fGry4WVQKYwFE4II5nVufElzRT4bTt+xcJ0e0F3fjj+9Ns31Vxj
         Qvn7gMcm3KFkbeicnsHLUWILSFmTt11radbcgSLDN8bJjboGFY7gBb/qxxjPXFucHvBX
         OtaCHJs2sEzv1xJNc1JLmHxonHl3HioTbMxCgM10uOLaTatgIr22zwjEIIXlST0/rUVI
         1XDqTxWQUbvmhO4qm7au7+6Mxa/zcqBhHm6VIZMfukgd1kxohY+CAPSU2aatH54ATYCP
         eGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=VnZAL0nBQUXclvhfgZG2Q/nAtL18/vmGeJE/PdQ+6So=;
        b=XrD+58EWP/zsk0zhhkuMVYJJ5rxsZ/w5vTYQApLzAcaD0FpFEyA+75MZkG2srmGFsF
         qOppzkNSOyQcQ064cK/UAkR063Q1xwPWDeNHzFbjQmhNuCcnRu7jgglqTTbedPQrjTFj
         H9EfTFU/3P9D7+sjPTWnrt0TtotT8biDFEP8xx07PpAq3WEeUngNJxe7HAQGxbMUeuua
         3QHZ1rMUtDUJze3543Z7Zg34RFMNRij5/D1pg7UM5UCgAcj0D3RVF5NZUtbhUdC3o5LV
         gyKWonnhxWIwgCv6xg4NBwO7vF79mgO0Od6CZFoxt4kxGcY+eM3wRla55bY3zajM+I3j
         MNsA==
X-Gm-Message-State: AOAM532JhwGhBd6DgsxPRCDwWCjRYidi+smBK0VtO0+p+tEO/64xwEJL
        IJHsCNaQHNtcAB+kDMqArx8=
X-Google-Smtp-Source: ABdhPJwnZ+1jPkLGdpQG4PFP1F8b2twk8Cv77IesCJfyJNe2iuvYHWLFpWJHQuwnPQ5je7DoRNyF2Q==
X-Received: by 2002:a05:6000:1685:b0:204:483:77ab with SMTP id y5-20020a056000168500b00204048377abmr2184613wrd.295.1647718005662;
        Sat, 19 Mar 2022 12:26:45 -0700 (PDT)
Received: from [172.20.10.7] ([102.89.2.112])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm4946414wrq.44.2022.03.19.12.26.38
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 19 Mar 2022 12:26:44 -0700 (PDT)
Message-ID: <62362e74.1c69fb81.69601.31d9@mx.google.com>
From:   Maria Elisabeth Schaeffler <muhammadbelloh642@gmail.com>
X-Google-Original-From: Maria Elisabeth Schaeffler <info@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Ich bin Frau Maria Elisabeth Schaeffler
To:     Recipients <info@gmail.com>
Date:   Sat, 19 Mar 2022 20:26:23 +0100
Reply-To: mariaelisabethschaeffler51@gmail.com
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen, die restlichen 25% dieses Ja=
hr 2022 an Einzelpersonen zu verschenken. Ich habe mich entschieden, 1.500.=
000,00 Euro an Sie zu spenden. Wenn Sie an meiner Spende interessiert sind,=
 kontaktieren Sie mich f=FCr weitere Informationen.

Unter folgendem Link k=F6nnen Sie auch mehr =FCber mich erfahren

https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
E-Mail: mariaelisabethschaeffler51@gmail.com
