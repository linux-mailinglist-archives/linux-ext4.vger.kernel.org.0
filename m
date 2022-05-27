Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2752853649A
	for <lists+linux-ext4@lfdr.de>; Fri, 27 May 2022 17:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243547AbiE0PWI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 May 2022 11:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiE0PWH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 May 2022 11:22:07 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7F762F5;
        Fri, 27 May 2022 08:22:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24RFLis3024874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 11:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1653664907; bh=yq+iAzud+p1UYdhfLiS74v2PiRi+/nVB9VPSJaqxO+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fWJxbyr1z1tgN5pWOPNUX+Dk2OHchCiA7c0I3zA+10a8bJr35g5pD8fQ6y6cQ26Rh
         AyZSvE8T1pISSzS2xSq2/mUQ7S+5839CZRjxQwhSWmQTXzvvnjVSrxddvaBbBxoCXD
         jKdfSODqEVfVlQN85VbXOdg/gFAsYrzWmssR/S/1q1xvOsoGQU+3lhq1qbaSxsj5TK
         TXZ9XwLP2vfwGtWWLjacIJEx1uKusY3wS/G/BMTcrhRgLavCu3n+ug6vNtzR3eYtAx
         bN7yZJWIKGdxIx8GieXyNdz7MwOeaS1X3CLQLu8eHl0KjG0/6dN9Wl3vdLmYURMyx3
         zLFKF+wkCKPyQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BA8A115C3399; Fri, 27 May 2022 11:21:44 -0400 (EDT)
Date:   Fri, 27 May 2022 11:21:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     yebin <yebin10@huawei.com>
Cc:     Eric Whitney <enwlinux@gmail.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next] ext4: Fix warning in ext4_da_release_space
Message-ID: <YpDsiCTi8sidvO7X@mit.edu>
References: <20220520025540.3189247-1-yebin10@huawei.com>
 <Yo/bRxbM8OBP0JlI@debian-BULLSEYE-live-builder-AMD64>
 <62909593.2040809@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62909593.2040809@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 27, 2022 at 05:10:43PM +0800, yebin wrote:
> 
> Maybe  you can  run syzkaller with log as follows :

Oh, so this was something that was found using Syzkaller.  Was this
using the public syzkaller; if so, can you provide a link the
Syzkaller report?

If this was a from privately run syzkaller instance, was there a C
reproducer?  It appears that this was from a fuzzed instance, and it's
painful enoguh to extract the file system image from the C reproducer.
I have no idea how to extract the file system image from a Syzkaller
reproducer.

In any case, it sounds like this was triggered from a maliciously
corrupted / fuzzed image.  Can this warning be triggered from a
consistent file system, or does it require a corrupted extent tree?

	   		   	   	   - Ted
