Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B71B4E5F
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 14:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfIQMrm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 08:47:42 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:46921 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbfIQMrm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Sep 2019 08:47:42 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8HClFEW027646;
        Tue, 17 Sep 2019 14:47:15 +0200
Date:   Tue, 17 Sep 2019 14:47:15 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190917124715.GA27634@1wt.eu>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 12:30:15PM +0000, Ahmed S. Darwish wrote:
> Sounds good?

Sounds good to me except that I'd like to have the option to get
poor randoms. getrandom() is used when /dev/urandom is not accessible
or painful to use. Until we provide applications with a solution to
this fairly common need, the problem will continue to regularly pop
up, in a different way ("my application randomly crashes at boot").
Let's get GRND_INSECURE in addition to your change and I think all
needs will be properly covered.

Thanks,
Willy
