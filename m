Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817594ECBE0
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Mar 2022 20:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350521AbiC3S0K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Mar 2022 14:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350501AbiC3S0F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Mar 2022 14:26:05 -0400
X-Greylist: delayed 8185 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 11:23:08 PDT
Received: from zsmtp-out1.bppt.go.id (mail.bppt.go.id [103.224.137.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728B53FBD7;
        Wed, 30 Mar 2022 11:23:07 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zsmtp-out1.bppt.go.id (Postfix) with ESMTP id 19B9C87671;
        Wed, 30 Mar 2022 22:35:40 +0700 (WIB)
Received: from zsmtp-out1.bppt.go.id ([127.0.0.1])
        by localhost (zsmtp-out1.bppt.go.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9c7HwdizIHJN; Wed, 30 Mar 2022 22:35:39 +0700 (WIB)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zsmtp-out1.bppt.go.id (Postfix) with ESMTP id 511AB8756B;
        Wed, 30 Mar 2022 22:35:37 +0700 (WIB)
DKIM-Filter: OpenDKIM Filter v2.10.3 zsmtp-out1.bppt.go.id 511AB8756B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bppt.go.id;
        s=selector; t=1648654537;
        bh=W5OBf/pcqsI4R4ZVP+6553vqwfG2usLrrRoBYAMFLCQ=;
        h=Date:From:Message-ID:MIME-Version;
        b=l6QiyCChAyfWB/kcczT+0U+p5oeXKeGzmNWztIA1JQFux02v1dd+JtisRjz06pIni
         f3tp7zMi238ZIJX+trWnL+GuQUsVAAchgMymKV9BI1STiWEU2TbJVbh+oH5WoR0RP+
         RAXRNljYTPIhMjnbENKKspQb+v1y9fMX02BuIwj8=
X-Amavis-Modified: Mail body modified (using disclaimer) -
        zsmtp-out1.bppt.go.id
X-Virus-Scanned: amavisd-new at bppt.go.id
Received: from zsmtp-out1.bppt.go.id ([127.0.0.1])
        by localhost (zsmtp-out1.bppt.go.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2rLpHvSZDEwL; Wed, 30 Mar 2022 22:35:37 +0700 (WIB)
Received: from mta1.bppt.go.id (mta1.bppt.go.id [10.10.180.6])
        by zsmtp-out1.bppt.go.id (Postfix) with ESMTPS id 65D21872EE;
        Wed, 30 Mar 2022 22:35:34 +0700 (WIB)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mta1.bppt.go.id (Postfix) with ESMTP id B4CBF253B4;
        Wed, 30 Mar 2022 22:35:32 +0700 (WIB)
Received: from mta1.bppt.go.id ([127.0.0.1])
        by localhost (mta1.bppt.go.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id g-YTUd6H-wKW; Wed, 30 Mar 2022 22:35:32 +0700 (WIB)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mta1.bppt.go.id (Postfix) with ESMTP id E04AD25405;
        Wed, 30 Mar 2022 22:35:29 +0700 (WIB)
X-Virus-Scanned: amavisd-new at mta1.bppt.go.id
Received: from mta1.bppt.go.id ([127.0.0.1])
        by localhost (mta1.bppt.go.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PNjMvEiXNB7Y; Wed, 30 Mar 2022 22:35:28 +0700 (WIB)
Received: from mbox2.bppt.go.id (mbox2.bppt.go.id [10.10.180.5])
        by mta1.bppt.go.id (Postfix) with ESMTP id 6B0B724F4D;
        Wed, 30 Mar 2022 22:35:20 +0700 (WIB)
Date:   Wed, 30 Mar 2022 22:35:20 +0700 (WIB)
From:   Nadirah <nadirah@bppt.go.id>
Reply-To: huangjinping@winghang.info
Message-ID: <342392754.4896193.1648654520349.JavaMail.zimbra@bppt.go.id>
Subject: Aw:Dringende Antwort erforderlich
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_4101 (zclient/8.8.15_GA_4101)
Thread-Index: RP7QbHaLlZ3G2nK9zJZYN/8O1GyCNg==
Thread-Topic: Dringende Antwort erforderlich
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,
        MISSING_HEADERS,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Es tut mir leid, dass ich Ihnen diese E-Mail, die in Ihrem Junk-Ordner eing=
egangen ist, als unerw=C3=BCnschte E-Mail gesendet habe. Ich hei=C3=9Fe Hua=
ng Jinping. Ich habe einen Gesch=C3=A4ftsvorschlag f=C3=BCr Sie. Ich wei=C3=
=9F, dass dieser Gesch=C3=A4ftsvorschlag f=C3=BCr Sie von Interesse sein w=
=C3=BCrde. F=C3=BCr weitere Informationen kontaktieren Sie mich bitte *****=
***************************************************************************=
**********#################################################################=
####################################
Isi e-mail ini mungkin bersifat rahasia dan penyalahgunaan, penyalinan, atau penyebaran dari e-mail ini dan semua attachment dari e-mail ini dilarang. Komunikasi internet tidak aman dan oleh karena itu Badan Pengkajian dan Penerapan Teknologi tidak menerima tanggung jawab hukum atas isi pesan ini atau untuk setiap kerusakan yang disebabkan oleh virus. Pendapat-pendapat yang diungkapkan di sini tidak selalu mewakili Badan Pengkajian dan Penerapan Teknologi.

