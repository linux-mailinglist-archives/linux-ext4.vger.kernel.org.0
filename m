Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550BA59275B
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Aug 2022 03:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiHOBIM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 14 Aug 2022 21:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiHOBIM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 14 Aug 2022 21:08:12 -0400
Received: from resqmta-c1p-023464.sys.comcast.net (resqmta-c1p-023464.sys.comcast.net [IPv6:2001:558:fd00:56::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F83C1116A
        for <linux-ext4@vger.kernel.org>; Sun, 14 Aug 2022 18:08:10 -0700 (PDT)
Received: from resomta-c1p-023411.sys.comcast.net ([96.102.18.231])
        by resqmta-c1p-023464.sys.comcast.net with ESMTP
        id NNaroQsIJNtPXNOaPoWUFa; Mon, 15 Aug 2022 01:08:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1660525689;
        bh=ptZZDHo/TjeQHCRToZtWF9/iyZ+0AQpDGCx8I8iLPw4=;
        h=Received:Received:Date:From:To:Message-ID:Subject:MIME-Version:
         Content-Type;
        b=iO5yXDshQzJ/7/hMxIqzqbkktOPKPV1zpSpHG/4rCZI1BB4I2r23XBVqyHzHIrVeg
         ZF2Gga5pNpd7yq+IgeK22JixsK2I29rugLJqWQQq/Ne9c7FBtlOXVVnsl9M3HsVFBH
         yYiw4mpXFVYbpOGy19H/6KW2ZejsGXNX4YYWpvQzPfFIaTo0/c+Vbrrnih3v4vRP/y
         q/1WDy1r3I3P8LFYkObnZ5cEgfSasOnER/qmIEQzJDuJaER9Q2xv9DqEqUP6u3IUsP
         olpZA0W9r3fNlC3Q3Tssuim0nRSrgaFhqHN7+1MxqlbBK6DAXhO145wA+6PjuuUHkI
         yGmKyYRMieCLw==
Received: from oxapp-hob-43o.email.comcast.net ([96.118.26.7])
        by resomta-c1p-023411.sys.comcast.net with ESMTPS
        id NOaOoUxAkLVVcNOaPoVvHM; Mon, 15 Aug 2022 01:08:09 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddggeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvkffugggtgffrkgfoihesthejsgdtredtjeenucfhrhhomhepfdffrdcuufhtihhmihhtshdfuceoshhtihhmihhtshestghomhgtrghsthdrnhgvtheqnecuggftrfgrthhtvghrnhephfehffdtgeeghedvledtledvudegjefhtdevueeuueehgfeufeejveffvedtudffnecukfhppeeliedruddukedrvdeirdejpddviedtudemvdekfeemkedttddumegrudgutdemmehfheelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehogigrphhpqdhhohgsqdegfehordgvmhgrihhlrdgtohhmtggrshhtrdhnvghtpdhinhgvthepleeirdduudekrddviedrjedpmhgrihhlfhhrohhmpehsthhimhhithhssegtohhmtggrshhtrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Xfinity-VMeta: sc=0.00;st=legit
Date:   Sun, 14 Aug 2022 19:08:08 -0600 (MDT)
From:   "D. Stimits" <stimits@comcast.net>
To:     linux-ext4 <linux-ext4@vger.kernel.org>
Message-ID: <108000349.529858.1660525688786@connect.xfinity.com>
Subject: Find Path by Inode For Multiple Hard Links?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev21
X-Originating-IP: 2601:283:8001:a1d0::f599
X-Originating-Client: open-xchange-appsuite
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, 

I'm writing a simple tool to find the locations and dates of regular files on an ext4 filesystem which are unexpectedly showing up with multiple hard links (perhaps a script using "ln" without "-s" somewhere else). I'm trying to do this only in user space, and the naive approach would be that if I have a file name path with a known inode number, that I would then scan the entire partition for all files, and note when the inode matches. Then create my report based on details of each full path. What I am wondering is if there is a more efficient way (in user space) to present an inode number, and enumerate all file paths with that inode, and not have to scan the entire disk? If there is no other way I could do it the slow way, but I'm thinking someone here might know of a simple way to bypass scanning an entire partition. So far I don't know how to extract paths given an inode number other than brute force searching.

Thanks!
