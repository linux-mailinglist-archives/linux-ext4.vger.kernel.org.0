Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1256F27A4
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 06:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjD3E4c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 00:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3E4b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 00:56:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479A31BC2
        for <linux-ext4@vger.kernel.org>; Sat, 29 Apr 2023 21:56:30 -0700 (PDT)
Received: from letrec.thunk.org ([76.150.80.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33U4u0Kr007396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 00:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682830564; bh=KZlbmySvO7dJiFKKCkQaeETSE5GXazM9UbzdjyOWm7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Z4BG3Dant07iY16ZS8h2R0jaAkAvltTw+cFBqQ/TnuzN1jbs0ub1hRwyPIjZ2PceQ
         tztQWk6gt5MmlFrNk6SA2S+X33jDRFSi8sQlLE7WQHxpRYFHg9oKNFIiVKHKXV21Qe
         ZRnBuavKck1YAOoS5Mp3ZZUgzlm9W3iXj7ZDDan3L5DMkzB0pUq2ACLVFB5K9IGpvH
         EBJU0ORg93I5VzvwP7xwfYzatk405TQEknkQfzAgOpYOTCjS2JZZluUNajYrcnkT2u
         wMvWkWBIg7S6Ob105GliELDpgdKeeYhloyy9sF4aFTr7TqJAbdZi9IJkhc+jjDCjH8
         BNj6HS44nzrmw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id AA2168C023E; Sun, 30 Apr 2023 00:55:59 -0400 (EDT)
Date:   Sun, 30 Apr 2023 00:55:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+9a44753ac327c557796a@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, chris@chris-wilson.co.uk,
        dvyukov@google.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.kuoppala@linux.intel.com,
        rodrigo.vivi@intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in ext4_set_page_dirty
Message-ID: <ZE3030tKPvwU7fIc@mit.edu>
References: <089e0825cec8180a2b0568c4ee1d@google.com>
 <0000000000005a390a05b2361916@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005a390a05b2361916@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

#syz dup: WARNING in ext4_dirty_folio
#syz set subsystems: mm

ext4_set_page_dirty() was renamed to ext4_dirty_folio() in commit
e621900ad28b ("fs: Convert __set_page_dirty_buffers to
block_dirty_folio") in February 2022 --- which explains why it hasn't
reproduced in over 400 days,

(I assume marking it is the right thing to do, although the syzkaller
documentation doesn't explain exactly what happens after you mark the
report as a dup.  The other possibility would be to marking it as
invalid, to drop this as noise.  But that feels wrong, so I'm guessing
marking it as a dup is the best way to handle this kind of situation.)

I'm moving this to the mm subsystem, since the root cause is the
get_user_pages issue that has been with us for years, with discussions
as early as the 2018 LSF/MM.

					- Ted
