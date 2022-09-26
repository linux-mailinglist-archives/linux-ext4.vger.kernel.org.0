Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5AB5E9895
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Sep 2022 07:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiIZFCN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Sep 2022 01:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIZFCL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Sep 2022 01:02:11 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1F227DE4
        for <linux-ext4@vger.kernel.org>; Sun, 25 Sep 2022 22:02:09 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28Q520tf019996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 01:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664168522; bh=jyHSc4WI+9ZiyCOCVatXv9Qxu1PZMMTli7eazX0w7bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=FoCu1xab7z07XxyKx1iact58b2HnNeDkPzlsMG+q2GLAGVsG2XxGz+1XMNKHm+IpL
         LrZeibWEu7W5vstSotG+odNwvH4UFcVc1sOhVQk4/ZusuFFxS3q2P6F4OQ3cqv/eF2
         +QdxcAv2kn04jCZPWal1ytGINNcJ5HehMuDMpDN137BL7ApKNp/Z8BktaV31YtVgWW
         uE3dfGEuK6OW/21Hx+WBNADOCsKiMzCP1iA5qfekHgkHAYV3D9XSZ1PrDcur1FNvpX
         WRMCpjw+e5nkaKV+of2u05KnlD7EaXjvr6OF93V+9PL3YJheGn4y9cjAahFILTdyFg
         AC5YHAjWTt3lg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BC37415C5274; Mon, 26 Sep 2022 01:02:00 -0400 (EDT)
Date:   Mon, 26 Sep 2022 01:02:00 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     bugzilla-daemon@kernel.org
Cc:     linux-ext4@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [Bug 216529] New: [fstests generic/048] BUG: Kernel NULL pointer
 dereference at 0x00000069, filemap_release_folio+0x88/0xb0
Message-ID: <YzEySPNMuIcfsda9@mit.edu>
References: <bug-216529-13602@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-216529-13602@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 25, 2022 at 11:55:29AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216529
> 
> 
> Hit a panic on ppc64le, by running generic/048 with 1k block size:

Hmm, does this reproduce reliably for you?  I test with a 1k block
size on x86_64 as a proxy 4k block sizes on PPC64, where the blocksize
< pagesize... and this isn't reproducing for me on x86, and I don't
have access to a PPC64LE system.

Ritesh, is this something you can take a look at it?  Thanks!

	   		      	       - Ted
