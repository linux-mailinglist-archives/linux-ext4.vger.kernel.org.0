Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0265ECBE0
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Sep 2022 20:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiI0SGg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Sep 2022 14:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbiI0SGf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Sep 2022 14:06:35 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371D6DB972
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 11:06:34 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28RI6Ms4023728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 14:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664301983; bh=yhvaj0nUCk4OWFKWOKG5BcM/LVVS+o0Dw7Fp/Y7/LyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HVUgh33KCBG1I7Ld+5xfGZ1fv6S8SO1Kcw3XG1IbLkq6QeshsawrkzXYekp2TtyQs
         dGxLqWnAcp+GtkrYCyqZSFY5URVUaG9ObcohjKgOJOC2KlGThWEaW/ewftC0nNT1h4
         OlXeIoZYRwh826p3qpXTgcZAZhGqpC89NjpMgnUQNDI/3iyhE7XoiOMBB1DO5Jvw4Y
         eAGxUHHHadgklUzow5Yny+huq8rE6P6R3lvusEtH3qHD62ZbTl/0S/R9tt68GAMWol
         OCfEf43cj+5OwCVHBdYekcBbQtbVNdG2zidSySC/33NbYWZeHtqoplkvZdK3/JN2nS
         MZcv94Fxy/oBQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 14B5D15C5266; Tue, 27 Sep 2022 14:06:22 -0400 (EDT)
Date:   Tue, 27 Sep 2022 14:06:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     bugzilla-daemon@kernel.org
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [Bug 216529] [fstests generic/048] BUG: Kernel NULL pointer
 dereference at 0x00000069, filemap_release_folio+0x88/0xb0
Message-ID: <YzM7nhdg8mLhkgSB@mit.edu>
References: <bug-216529-13602@https.bugzilla.kernel.org/>
 <bug-216529-13602-My2i8BoSN7@https.bugzilla.kernel.org/>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-216529-13602-My2i8BoSN7@https.bugzilla.kernel.org/>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 27, 2022 at 12:47:02AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=216529
> 
> Yes, it's reproducible for me, I just reproduced it again on another ppc64le
> (P8) machine [1]. But it's not easy to reproduce by running generic/048 (maybe
> there's a better way to reproduce it).

Can you give a rough percentage of how often it reproduces?  e.g.,
does it reproduces 10% of the time?  50% of the time?  2-3 times after
100 tries, so 2-3%?  etc.  If it reproduces but rarely, it'll be a lot
harder to try to bisect.

Something perhaps to try is to enable KASAN, since both stack traces
seem to involve a null pointer derference while trying to free
buffers.   Maybe that will give us some hints towards the cause....

Thanks,

						- Ted
