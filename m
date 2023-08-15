Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F115F77CCF6
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 14:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbjHOMwO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 08:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbjHOMwG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 08:52:06 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDEE172A
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 05:52:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-114-154.bstnma.fios.verizon.net [173.48.114.154])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37FCpkTm023020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 08:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692103908; bh=sYrp9LrLuil8xIlfdGEAsRkSlkgtAiaHvWYOVyY+mkI=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=IwXqJ5cQwH02uowWnpTrer4xdovuo8DSGI1gYenUl6jVKwOSNxBOscm51nWE2/+PN
         el/LsvYrW0IfPATDoNfH5Qr6xeKPzeZlnqctUIHZ9SnfUDwweZHvh9vDeJVeButP6A
         dP2L8X604SdvQ+joU5V2OkQOUK2Rdy4Vh75D513LVbFwDz+W+WEb+V3X8i/izehOzd
         X1f+yNjFmy2KSSEj+Tg4trnQIHn0qUMiSfzAz7Ssi7JjtgFafYaiD1PnDkMzR8S/0Q
         bD+RfAOokFPUv5fJ2jUl5zjtp8JJrbiT9N5aRLjDcfgRAsRqHcA1hvz0eI0MDg8H9j
         Uf2U6J4nlmp1w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6ACCF15C0292; Tue, 15 Aug 2023 08:51:46 -0400 (EDT)
Date:   Tue, 15 Aug 2023 08:51:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Dr. David Alan Gilbert" <dave@treblig.org>
Cc:     adilger.kernel@dilger.ca, song@kernel.org,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: 6.5.0rc5 fs hang - ext4? raid?
Message-ID: <20230815125146.GA1508930@mit.edu>
References: <ZNqWfQPTScJDkmpX@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNqWfQPTScJDkmpX@gallifrey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 14, 2023 at 09:02:53PM +0000, Dr. David Alan Gilbert wrote:
> dg         29594   29592  0 18:40 pts/0    00:00:00 /usr/bin/ar --plugin /usr/libexec/gcc/x86_64-redhat-linux/13/liblto_plugin.so -csrDT src/intel/perf/libintel_perf.a src/intel/perf/libintel_perf.a.p/meson-generated_.._intel_perf_metrics.c.o src/intel/perf/libintel_perf.a.p/intel_perf.c.o src/intel/perf/libintel_perf.a.p/intel_perf_query.c.o src/intel/perf/libintel_perf.a.p/intel_perf_mdapi.c.o
> 
> [root@dalek dg]# cat /proc/29594/stack 
> [<0>] md_super_wait+0xa2/0xe0
> [<0>] md_bitmap_unplug+0xd2/0x120
> [<0>] flush_bio_list+0xf3/0x100 [raid1]
> [<0>] raid1_unplug+0x3b/0xb0 [raid1]
> [<0>] __blk_flush_plug+0xd7/0x150
> [<0>] blk_finish_plug+0x29/0x40
> [<0>] ext4_do_writepages+0x401/0xc90
> [<0>] ext4_writepages+0xad/0x180

If you want a few seconds and try grabbing cat /proc/29594/stack
again, what does the stack trace stay consistent as above?

Also, if you have iostat installed (usually part of the sysstat
package), does "iostat 1" show any I/O activity on the md device?
What about the underying block dvices used by the md device?  If the
md device is attached to HDD's where you can see the activity light,
can you see (or hear) any disk activity?

This sure seems like either the I/O driver isn't processing requests,
or some kind of hang in the md layer....

				- Ted
