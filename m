Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E412744A48
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Jul 2023 17:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjGAPfd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 1 Jul 2023 11:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGAPfd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 1 Jul 2023 11:35:33 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484C38F;
        Sat,  1 Jul 2023 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kCNrk+ARuX6SCOmc24SortMveTD7s/DdF3ybwqHKKas=; b=ZJo/tIQVRPN1zG9rUSNNXqUhDk
        pzAX7LSBGw813Dm4OyCV/fidzBwxYbJKKTtd3mPn9a4/5g+fp0eoJWuqACtifDOOXU4OQ4BeUleSs
        N8DbHEQH0/ZkLiI6B8MIjpiecY7Tyovn9ZwtJHsoPrq/Fw8SErweswq9wGIexRdb+aHSnITd4UXQA
        bSriRqbLjJZKFJMuBd0M1O/Qs2Y3ebUSBsEpfTJ9XBcpMEnnelW2H82uvzYDziAnj/GeGuwU2OD4i
        CSnX6JWM00Be6U/j76uGkcS1OZaDXNrXR+o/drprxOBi7KeOQZ1qX2oNk9ppUoatM5fwYpRI3Q+kE
        QiLuR/rw==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <carnil@debian.org>)
        id 1qFcd8-007yI0-I5; Sat, 01 Jul 2023 15:35:22 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
        id A70BFBE2DE0; Sat,  1 Jul 2023 17:35:21 +0200 (CEST)
Date:   Sat, 1 Jul 2023 17:35:21 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     dud225 <dud225@hotmail.com>, 1039883@bugs.debian.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bug#1039883: linux-image-6.3.0-1-amd64: ext4 corruption with
 symlinks
Message-ID: <ZKBHuRSrs96JDZjY@eldamar.lan>
References: <168802788716.2369531.1979971093539266086.reportbug@ariane.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168802788716.2369531.1979971093539266086.reportbug@ariane.home>
X-Debian-User: carnil
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Control: tags -1 + upstream

Hi,

On Thu, Jun 29, 2023 at 10:38:07AM +0200, dud225 wrote:
> Package: linux-image-6.3.0-1-amd64
> Version: linux-image-6.3.0-1-amd64
> Severity: important
> Tags: upstream
> X-Debbugs-Cc: dud225@hotmail.com
> 
> Hello
> 
> I've stored data on a USB external hard drive using ext4 over LUKS2 and I'm getting the following error:
> 	kernel: EXT4-fs error (device dm-11): ext4_map_blocks:607: inode #8159552: block 959787320: comm git-annex:w: lblock 0 mapped>
> 
> I then stumbled upon that kernel bug [1] which matches my case as git-annex is making heavy use of symlinks. However I've faced this issue on the kernel 6.3.0 (linux-image-6.3.0-1-amd64 version 6.3.7-1) so it doesn't look to be actually addressed.
> 
> I've got 3 disks, 2 HDDs and 1 SSD, and oddly the failure only happens on the HDD, the SSD is running fine.
> After reformatting my HDD without the inline_data feature, the issue has disappeared.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=216317

I believe this should be reported upstream, doing so now to get some
ideas from Ted and Andreas. 

Ted, Andreas the above was reported in Debian at
https://bugs.debian.org/1039883 .

Any insights here?

Regards,
Salvatore
