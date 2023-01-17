Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B391C66DB9B
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jan 2023 11:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbjAQKza (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Jan 2023 05:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbjAQKz0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Jan 2023 05:55:26 -0500
Received: from leela.pocnet.net (leela.pocnet.net [87.193.61.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D252305C2
        for <linux-ext4@vger.kernel.org>; Tue, 17 Jan 2023 02:55:23 -0800 (PST)
Received: from smtpclient.apple (imini.pocnet.net [192.168.59.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: poc)
        by leela.pocnet.net (Postfix) with ESMTPSA id 8DE73280B37;
        Tue, 17 Jan 2023 11:55:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pocnet.net; s=m201510;
        t=1673952920; bh=iF141JWrr4U+rfEE2GVfVeUG4QLtNWzPpEQug+xl9bs=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=My8RGc2Yc+pkaLT52O+idHEXgmeODOKMEaseE5ep6Lq9zfzNxqinZUQyBChSVN34C
         PciZlfX3oCzyE9WY190g9Z6hm2GDn3w6aP2G8iKusfZvkDIIvw1iuaF3J48pXpPfCH
         qUmNXl9S0MHQyrgmTAklohLJQnCS6eTWmKMuQ7wA=
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: ext4: Remove deprecated noacl/nouser_xattr options
From:   Patrik Schindler <poc@pocnet.net>
In-Reply-To: <20230117104525.kmbypv4vca6lbd5a@quack3>
Date:   Tue, 17 Jan 2023 11:55:18 +0100
Cc:     linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <06B5ADDC-D887-4C63-80BE-20950B7AAB75@pocnet.net>
References: <A5F622F8-99CF-4C7D-8811-7D82DB1C8846@pocnet.net>
 <20230116104254.xpphncpzu3zf53va@quack3>
 <3C7004E8-E732-40C1-B0DD-2A2290E43AC5@pocnet.net>
 <20230117104525.kmbypv4vca6lbd5a@quack3>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Jan,

Am 17.01.2023 um 11:45 schrieb Jan Kara <jack@suse.cz>:

> I understand the wish for more overview over file permissions but this =
seems like a bit awkward way to reach it?

This might be a matter of taste.

> It rather seems like a lack of control in the smbget(1) tool (or =
whatever you are using for the copying)?

Im using my Mac with macOS. I mount a samba share and use the Finder to =
copy files by drag & drop.

> Adding an option there to not copy permissions from the server would =
look like a very logical thing to do (similarly as cp(1) has these =
options)...  Would that work?

In this case: No, wouldn't work.

But your response made me wade through smb.conf(5) again, specifically =
searching for "acl" and found:

nt acl support =3D no

to be the adequate solution after trying. With that, copying files =
doesn't add ACLs anymore.

Sorry for bugging you and all the list members. Thank you for helping me =
think. :-)

:wq! PoC

