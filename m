Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1EF9FBF97
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2019 06:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKNF1A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Nov 2019 00:27:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41998 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbfKNF1A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Nov 2019 00:27:00 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAE5QqlU008732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 00:26:53 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 373024202FD; Thu, 14 Nov 2019 00:26:52 -0500 (EST)
Date:   Thu, 14 Nov 2019 00:26:52 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/19 v3] ext4: Fix transaction overflow due to revoke
 descriptors
Message-ID: <20191114052652.GB11994@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191112220614.GA11089@mit.edu>
 <20191113094545.GC6367@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113094545.GC6367@quack2.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 13, 2019 at 10:45:45AM +0100, Jan Kara wrote:
> Thanks for the heads up! I didn't do any performance testing with the jbd2
> changes specifically and our internal performance testing grid only checks
> Linus' kernel so it didn't yet even try to run that code. I'll queue some
> sqlite insert tests internally with my changes to see whether I'm able to
> reproduce. I don't have NVME disks available quickly but I guess SATA SSD
> could do the job as well...

Sorry, false alarm.  What Phoronix was testing was 5.3 versus 5.4-rcX,
using Ubuntu's bleeding-edge kernels.  It wouldn't have any of the
ext4 patches we have queued for the *next* merge window.

That being said, I wasn't able to reproduce performance delta using
upstream kernels, running on a Google Compute Engine VM, machtype
n1-highcpu-8, using a GCE Local SSD (SCSI-attached) for the first
benchmark, which I believe was the pts/sqlite benchmark using a thread
count of 1:

     Phoronix Test Suite 9.0.1
     SQLite 3.30.1
     Threads / Copies: 1
     Seconds < Lower Is Better
     5.3.0 ..................... 225 |===========================================
     5.4.0-rc3 ................. 224 |==========================================
     5.4-rc3-80-gafb2442fa429 .. 227 |===========================================
     5.4.0-rc7 ................. 223 |==========================================

     Processor: Intel Xeon (4 Cores / 8 Threads), Chipset: Intel 440FX
     82441FX PMC, Memory: 1 x 7373 MB RAM, Disk: 11GB PersistentDisk +
     403GB EphemeralDisk, Network: Red Hat Virtio device

     OS: Debian 10, Kernel: 5.4.0-rc3-xfstests (x86_64) 20191113, Compiler:
     GCC 8.3.0, File-System: ext4, System Layer: KVM

This was done using an extension to a gce-xfstests test appliance, to
which I hope to be adding an automation engine where it will kexec
into a series of kernels, run the benchmarks and then spit out the
report somewhere.  For now, the benchmarks are run manually.

(Adding commentary and click-baity titles is left as an exercise to
the reader.  :-)

						- Ted
						
P.S.  For all that I like to make snarky comments about Phoronix.com,
I have to admit Michael Larabel has done a pretty good job with his
performance test engine.  I probably would have choosen a different
implementation than PHP, and I'd have added an explicit way to specify
the file system to be tested other than mounting it on top of
/var/lib/phoronix-test-suite, and at least have the option of placing
the benchmarks' build trees and binaries in a different location than
the file system under test.

But that being said, he's collecting a decent set of benchmark tools,
and it is pretty cool that it has an automated way of collecting the
benchmark results, including the pretty graphs suitable for web
articles and conference slide decks ("and now, we turn to the rigged
benchmarks section of the presentation designed to show my new feature
in the best possible light...").
