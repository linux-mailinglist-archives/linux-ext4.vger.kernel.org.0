Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8923877CD03
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjHOMz7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 08:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjHOMzx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 08:55:53 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB829C;
        Tue, 15 Aug 2023 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=dx2GfDDDoYu01j/c0eIwGomHhr611JnPlv24PQGbTjg=; b=N/9TGdewmaAVL+aTrY0SzpBAA+
        GHIy9PaRYLe1jbPEqXsl512QdTys9iivqyuhb56UZcI4oD1wCauqAoPfKFGH2nZDJ5nnvZuiRh6Na
        pYMnpJwdA8IwzB1LpHzclk54oHRLSfYCwA3DYYA4KY2ENjekF1PIP2DJihOWdvZR1XkIPC6/oHOHc
        gEMv8XM+Hq4rP+nQK6K7XDCj8LpSnFjOVAKC+ANhXOvEVU70rkqdGDPwuaNdCoxRu/TJ6fdtU5S/3
        1mbyU8QjFjcuV1UnJvkRSTL+TIIvR0g7Ix2ldzyjabJuta81MDV2oYuMKC0mNVJ93cx35u5RwX0Rw
        yH7cOgNA==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qVtaP-0073K8-7R; Tue, 15 Aug 2023 12:55:49 +0000
Date:   Tue, 15 Aug 2023 12:55:49 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, song@kernel.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
Message-ID: <ZNt11WbPn7LCXPvB@gallifrey>
References: <ZNqWfQPTScJDkmpX@gallifrey>
 <20230815125146.GA1508930@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230815125146.GA1508930@mit.edu>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 12:55:06 up 39 days, 22:26,  1 user,  load average: 0.00, 0.01, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Theodore Ts'o (tytso@mit.edu) wrote:
> On Mon, Aug 14, 2023 at 09:02:53PM +0000, Dr. David Alan Gilbert wrote:
> > dg         29594   29592  0 18:40 pts/0    00:00:00 /usr/bin/ar --plugin /usr/libexec/gcc/x86_64-redhat-linux/13/liblto_plugin.so -csrDT src/intel/perf/libintel_perf.a src/intel/perf/libintel_perf.a.p/meson-generated_.._intel_perf_metrics.c.o src/intel/perf/libintel_perf.a.p/intel_perf.c.o src/intel/perf/libintel_perf.a.p/intel_perf_query.c.o src/intel/perf/libintel_perf.a.p/intel_perf_mdapi.c.o
> > 
> > [root@dalek dg]# cat /proc/29594/stack 
> > [<0>] md_super_wait+0xa2/0xe0
> > [<0>] md_bitmap_unplug+0xd2/0x120
> > [<0>] flush_bio_list+0xf3/0x100 [raid1]
> > [<0>] raid1_unplug+0x3b/0xb0 [raid1]
> > [<0>] __blk_flush_plug+0xd7/0x150
> > [<0>] blk_finish_plug+0x29/0x40
> > [<0>] ext4_do_writepages+0x401/0xc90
> > [<0>] ext4_writepages+0xad/0x180
> 
> If you want a few seconds and try grabbing cat /proc/29594/stack
> again, what does the stack trace stay consistent as above?

I'll get back to that and retry it.

> Also, if you have iostat installed (usually part of the sysstat
> package), does "iostat 1" show any I/O activity on the md device?
> What about the underying block dvices used by the md device?  If the
> md device is attached to HDD's where you can see the activity light,
> can you see (or hear) any disk activity?

It's spinning rust, and I hear them go quiet when the hang happens.

Dave

> This sure seems like either the I/O driver isn't processing requests,
> or some kind of hang in the md layer....
> 
> 				- Ted
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
