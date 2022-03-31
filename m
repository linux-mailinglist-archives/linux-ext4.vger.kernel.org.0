Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D384ED64A
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Mar 2022 10:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbiCaI5C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Mar 2022 04:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiCaI5B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Mar 2022 04:57:01 -0400
X-Greylist: delayed 106 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Mar 2022 01:55:13 PDT
Received: from thsbbfxrt02p.thalesgroup.com (thsbbfxrt02p.thalesgroup.com [192.93.158.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B5FFFFB3
        for <linux-ext4@vger.kernel.org>; Thu, 31 Mar 2022 01:55:13 -0700 (PDT)
Received: from thsbbfxrt02p.thalesgroup.com (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 4KTcXQ1grDzJpVH
        for <linux-ext4@vger.kernel.org>; Thu, 31 Mar 2022 10:53:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalesgroup.com;
        s=xrt20181201; t=1648716806;
        bh=JQEpwSS6cVOhtk5ep51CccV2EkyNcjT7IXkfYkSXZ88=;
        h=From:To:Subject:Date:Message-ID:Content-Transfer-Encoding:
         MIME-Version:From;
        b=203bG2gR1+0kqexNpw0blhFXn/OXr+yqxfwQrlMVsq2Yk5aJ8LmFjPnUIpA8/fbjO
         jZl/Fd/yiw4cd/yrD2kU+83QZQ3xVfhpzowqg7c2ze5FAjVy107nZ+W4RZ/NjXHObD
         eS62YzVsqf2VU1fc5ApUXBD+cEOP4Ua+xj/0cULrhbvgGiKGMdbSReCrwvAUEJUsQ9
         hZ0NnYT7Kv/Qao1xnmz5SMsX9GxV2FbcolnBj1MZ0hffKE9Ur3vaqQTKnr0yD4OaCf
         I52d1QVoEPB+VU/k56+1TGylUSFDRjrvFbcOjR9Xa5du1zAMKIrTCUNBuE7VcuPTjD
         08kyX0C1oMCiw==
From:   HARDERS Bernd <Bernd.Harders@thalesgroup.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     PFLANZ Roger <Roger.Pflanz@thalesgroup.com>
Subject: Realtime behavior of named pipes
Thread-Topic: Realtime behavior of named pipes
Thread-Index: AdhE3JK5EaRAW4DnSuy167PS98wfow==
Date:   Thu, 31 Mar 2022 08:53:22 +0000
Message-ID: <bca722097ded477dbf62d5896bf01656@THSUMIDEUMSG03P.deu.umi.grp>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-pmwin-version: 4.0.1, Antivirus-Engine: 3.84.0, Antivirus-Data: 5.91
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_05,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,=20

my name is Bernd Harders, I'm working for the thales company and I just hav=
e analyzed a real-time issue in context of named pipes, ext4 and jbd2, usin=
g ftrace and trace compass.

While the issue can be fixed by moving the pipe to the ramfs, I want to und=
erstand what's going on under the hood.=20
I'm also interested in the question, if this issue belongs to the use of th=
e very old RedHat7 and kernel 3.10, or if this behavior is still to be expe=
ctable.=20

Here comes a short description of the behavior:

We have two high priority realtime threads, which communicate and synchroni=
ze in a high frequent manner using a named pipe. The named pipe directory e=
ntry is located on an ext4 partition, a lvm is in use.=20

I found that in seldom cases the threads are blocked  for milliseconds, whi=
le a block_io, forced by the jbd2/dm thread is active. In this case there i=
s no deterministic latency anymore, because it seems that the duration of t=
he blocking also depends on other block_io's. =20

Our idea is that this behavior is related to timestamp updates in the direc=
tory, forcing the journaling activities.=20

While I can totally understand that io to a file is blocked, when journalin=
g is doing its work, it is not obviously clear why this also happen on the =
pipe, because as I'm told the pipe io internally works to memory. We only w=
rite and read an integer value per transfer, so there is no need for tempor=
ary file io storage.

I'm looking forward to any explanations.

Best regards
Bernd Harders

{OPEN}


=A0
Bernd Harders
Senior Software Engineer
Naval Systems
Thales Deutschland
Switchboard Phone: +49 431-88737-344
Mobile: +49 172 828 14 50

E-Mail:=A0=A0 bernd.harders@thalesgroup.com

Thales Deutschland GmbH
Am Kiel-Kanal 3 - 24106 Kiel - Germany
=A0
[DEU] Achtung: Neue Anschrift!=20
[ENG] Attention: New address!
www.thalesgroup.com
=A0









Sitz der Gesellschaft/Domicile of the Company: Stuttgart
Amtsgericht/District Court: Stuttgart HRB 728793
Gesch=E4ftsf=FChrer/Managing Directors:
Oliver D=F6rre (Vorsitzender/Chairman), Dr. Henning Biebinger, Dirk J.H. de=
 Bruijn, Dr. Yves Joannic
Aufsichtsratsvorsitzender/Chairman of the Supervisory Board: Bernhard Gerwe=
rt


