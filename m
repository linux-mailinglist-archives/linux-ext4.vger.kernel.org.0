Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143B7498648
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jan 2022 18:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbiAXRRo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jan 2022 12:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244299AbiAXRRh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jan 2022 12:17:37 -0500
Received: from smtp5.epfl.ch (smtp5.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e034:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F07C061747
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jan 2022 09:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1643044654;
      h=From:To:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
      bh=HvykPgdqDq2ZIA0pExkdK6ltBkWsOmXo9FfzmK7jT1c=;
      b=DnhlMIFo02DUituBbob7keUVDChEeSNMFxq996yVMmWO1t+ejNswiiROJOWU/2SA1
        2pe5VFiBsLblHjz1Xv24hgiR1qhKvLo0R1W8I+UgaNpoSPR3SDIktBKpa6/OGjaXY
        PQwWDBKQKF5C10WVYiJMSaInKY/LCBjCyJwUkdEeE=
Received: (qmail 27410 invoked by uid 107); 24 Jan 2022 17:17:34 -0000
Received: from ax-snat-224-186.epfl.ch (HELO ewa11.intranet.epfl.ch) (192.168.224.186) (TLS, AES256-GCM-SHA384 cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Mon, 24 Jan 2022 18:17:34 +0100
X-EPFL-Auth: R/EupxFXVDvbJIb0e0oB43suN5XVnC46QEg2hyH1QdNM5chHmsM=
Received: from ewa07.intranet.epfl.ch (128.178.224.178) by
 ewa11.intranet.epfl.ch (128.178.224.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 24 Jan 2022 18:17:34 +0100
Received: from ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a]) by
 ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a%4]) with mapi id
 15.01.2308.020; Mon, 24 Jan 2022 18:17:34 +0100
From:   Lyu Tao <tao.lyu@epfl.ch>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: How does EXT4 ensures two processes don't modify and synchronize one
 page at the same time.
Thread-Topic: How does EXT4 ensures two processes don't modify and synchronize
 one page at the same time.
Thread-Index: AQHYEUYlxaL8ODP5KEKQsEOMAP2YQg==
Date:   Mon, 24 Jan 2022 17:17:34 +0000
Message-ID: <6fdeab9535134fc18e86968b10e726c6@epfl.ch>
Accept-Language: en-US, fr-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [178.199.230.7]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I'm new to file system area and have a naive question about the global sync=
.

Let's suppose there are two process are writing to the same file. If one pr=
ocess issues a sync() syscall, which mechanism can ensures the two processe=
s don't modify and synchronize one page at the same time.

Best,
Tao
