Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E537DE8D6
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Nov 2023 00:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346218AbjKAX3N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Nov 2023 19:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjKAX3N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Nov 2023 19:29:13 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252D8123
        for <linux-ext4@vger.kernel.org>; Wed,  1 Nov 2023 16:29:10 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-586f1db1a83so169963eaf.2
        for <linux-ext4@vger.kernel.org>; Wed, 01 Nov 2023 16:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1698881349; x=1699486149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m9D9sfHhqQD//T+0joi06c/klbHPqB5VbxNysl+FPJQ=;
        b=fmz9lDrcEy9qvklbrlhwcESMkHH26/plwaFv3FU3SQeTusQd019nZ5zniomKzC7ckE
         N33FdONRvAs9mnVMNnWec9f0CRx19io3sIMZj5J41GFJjT6VDkF6jpiaR2dfpSrWi7hm
         MwO9EMy3nlvfHxGEi6db7KffY5UObsVcL7uOk1WSokU1o8eHaQ0Em+rtEjEzYTJ9286h
         Zx8i/hD/wc/blYLZlli48qoPbpCkdzjyCuZE3ypVqGQmwPI2dPu9pfK9Drm/1u/wv5nU
         L1QD8EMORxFCxBfaX9hQRplK6kgoKQcOU1iM6lQRLfT9lgznbndkxLgqkh5WABxeoewt
         oqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698881349; x=1699486149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9D9sfHhqQD//T+0joi06c/klbHPqB5VbxNysl+FPJQ=;
        b=EReZru9uJFpjGE0baZXEKX9kJxIggR3GAFesaQrUWCVCQzkJX0dL9uPhSW64neC41j
         g99NdpilnLJ1GLygcZjhCUP7+z/0GC5pk7a254QJNP7x7XEygEIdAYr97OkxmKz17KTF
         xkDYLgpiZDFVJh83jTmxhFcI5Qf9bcrhzk5LrQGeZEq3jOP8dR5sqgNX5qC4OVXYmVv4
         ISG4jIJYG0HILNhmmC0019pzvlTm6CQ8jP96U8p2yBd5VjCsvSGOcEFnElcQVTjgTjip
         0wQwLJRvtuVHid9A7caFmJ7Tw0BLvlKNrrBBFuu/piVu2koJNKiG77zNMIkfX2j3D4Xq
         lQCA==
X-Gm-Message-State: AOJu0YyqyOJY2RfRJ+UsTiQE7EUFTLJv0484/NABc9yXW41vTo/NWW6b
        RP1fcv7okgqHUDL3BmBD5lSzgg==
X-Google-Smtp-Source: AGHT+IHBbuuxoCvj122hy4w+Q5lkHRxzDKw2Hawu2bpMvdgl9pcfnhSlloOBc2uNwlUNFzkm4O5+rA==
X-Received: by 2002:a05:6358:724d:b0:169:845b:3417 with SMTP id i13-20020a056358724d00b00169845b3417mr10842702rwa.25.1698881349037;
        Wed, 01 Nov 2023 16:29:09 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id e22-20020a637456000000b0058a9621f583sm354653pgn.44.2023.11.01.16.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 16:29:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qyKe0-006zm8-39;
        Thu, 02 Nov 2023 10:29:05 +1100
Date:   Thu, 2 Nov 2023 10:29:04 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jack@suse.cz" <jack@suse.cz>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "jstultz@google.com" <jstultz@google.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "chandan.babu@oracle.com" <chandan.babu@oracle.com>,
        "hughd@google.com" <hughd@google.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "jack@suse.de" <jack@suse.de>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
Message-ID: <ZULfQIdN146eZodE@dread.disaster.area>
References: <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area>
 <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
 <ZUBbj8XsA6uW8ZDK@dread.disaster.area>
 <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
 <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
 <ZUF4NTxQXpkJADxf@dread.disaster.area>
 <20231101101648.zjloqo5su6bbxzff@quack3>
 <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com>
 <3ae88800184f03b152aba6e4a95ebf26e854dd63.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ae88800184f03b152aba6e4a95ebf26e854dd63.camel@hammerspace.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 01, 2023 at 09:34:57PM +0000, Trond Myklebust wrote:
> On Wed, 2023-11-01 at 10:10 -1000, Linus Torvalds wrote:
> > The above does not expose *any* changes to timestamps to users, and
> > should work across a wide variety of filesystems, without requiring
> > any special code from the filesystem itself.
> > 
> > And now please all jump on me and say "No, Linus, that won't work,
> > because XYZ".
> > 
> > Because it is *entirely* possible that I missed something truly
> > fundamental, and the above is completely broken for some obvious
> > reason that I just didn't think of.
> > 
> 
> My client writes to the file and immediately reads the ctime. A 3rd
> party client then writes immediately after my ctime read.
> A reboot occurs (maybe minutes later), then I re-read the ctime, and
> get the same value as before the 3rd party write.
>
> Yes, most of the time that is better than the naked ctime, but not
> across a reboot.

This sort of "crash immediately after 3rd party data write" scenario
has never worked properly, even with i_version.

The issue is that 3rd party (local) buffered writes or metadata
changes do not require any integrity or metadata stability
operations to be performed by the filesystem unless O_[D]SYNC is set
on the fd, RWF_[D]SYNC is set on the IO, or f{data}sync() is
performed on the file.

Hence no local filesystem currently persists i_version or ctime
outside of operations with specific data integrity semantics.

nfsd based modifications have application specific persistence
requirements and that is triggered by the nfsd calling
->commit_metadata prior to returning the operation result to the
client. This is what persists i_version/timestamp changes that were
made during the nfsd operation - this persistence behaviour is not
driven by the local filesystem.

IOWs, this "change attribute failure" scenario is an existing
problem with the current i_version implementation.  It has always
been flawed in this way but this didn't matter a decade ago because
it's only purpose (and user) was nfsd and that had the required
persistence semantics to hide these flaws within the application's
context.

Now that we are trying to expose i_version as a "generic change
attribute", these persistence flaws get exposed because local
filesystem operations do not have the same enforced persistence
semantics as the NFS server.

This is another reason I want i_version to die.

What we need is a clear set of well defined semantics around statx
change attribute sampling. Correct crash-recovery/integrity behaviour
requires this rule:

  If the change attribute has been sampled, then the next
  modification to the filesystem that bumps change attribute *must*
  persist the change attribute modification atomically with the
  modification that requires it to change, or submit and complete
  persistence of the change attribute modification before the
  modification that requires it starts.

e.g. a truncate can bump the change attribute atomically with the
metadata changes in a transaction-based filesystem (ext4, XFS,
btrfs, bcachefs, etc).

Data writes are much harder, though. Some filesysetm structures can
write data and metadata in a single update e.g. log structured or
COW filesystems that can mix data and metadata like btrfs.
Journalling filesystems require ordering between journal writes and
the data writes to guarantee the change attribute is persistent
before we write the data. Non-journalling filesystems require inode
vs data write ordering.

Hence I strongly doubt that a persistent change attribute is best
implemented at the VFS - optimal, efficient implementations are
highly filesystem specific regardless of how the change attribute is
encoded in filesysetm metadata.

This is another reason I want to change how the inode timestamp code
is structured to call into the filesystem first rather than last.
Different filesystems will need to do different things to persist
a "ctime change counter" attribute correctly and efficiently -
it's not a one-size fits all situation....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
