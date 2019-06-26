Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2E455F05
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jun 2019 04:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfFZChV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jun 2019 22:37:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37438 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfFZChU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jun 2019 22:37:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id y8so415348pgl.4;
        Tue, 25 Jun 2019 19:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=grlVAwsoHm6qiNKeKxEtNH2ATBws2Wr1IWeBaz5cOck=;
        b=QviN5Lz3QKExaZRbMMxDWfFQLC7wZt58uJRrAvmzq6e+Jeb3IuozjH/q07w9APIy4v
         Zwf6Yj+I5M+acGFH3xZnLsBOHkV+lItcZX6G2xiUDLdwbDb3dBpByToMwYjyUXgz+nif
         Db8M6l5AhBJEa2YfSllwJ0fLT60+eSpRpgWiPFTUsPN/ax/QQolKdB1PI8HJIg68IL+0
         +c9mclfKWao5WNaDhp24x58Kbynd7CIpkS5pDYDrEzQhxjCbohV4WeDmmw0mneFSBs8l
         EBLwMiGl9rxWxBWMBheOQaYtB4yEqR/ZyDsqej696TLNp/tGJr7UNUKHuPfBMgOTmjCF
         rwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=grlVAwsoHm6qiNKeKxEtNH2ATBws2Wr1IWeBaz5cOck=;
        b=rlBxaWwoucfg8x0OP/ugF4nlwHY2PWAw27gsmF/KMDwCZvuqxYM4AOMmWbesZ38qdk
         YWNoWhTJ/Fy8zqv75ajSGvk4XZceq+uOww/t1ouIWKJEPAlsSM6JvZJh96W4BEYskwVy
         Me4j+REa90ZOO7Humje56vZR1m7cs4u/0TJqKJEt2xPHKEL9aVOsP/9eszKJgqaJVg57
         UJQzaDnJZBDREWubVf/3RC62WJlksOvI2FkWtJj8KkY8Xsfqp1pGJ0Oq2H2dWJy6E8aa
         TP+nf4n3zFTLWW00bF1JocbFDgm5f8y6Iqg6xVk9Rf4vx0BTs9TmNekTsZOIzSvXhFOj
         /QZQ==
X-Gm-Message-State: APjAAAUNjCJeJNNMac6aS/JwZFiEyd5Ff8gzTvjCz1VVIv3hM3aLXmvu
        BJNsu6br1Tt0Jroo5/KMR8k=
X-Google-Smtp-Source: APXvYqxkVg2DHEVLT/xevqx3R8fu7W9UlpkcAeeVbs+Xiv14ji5chXoNWu6JnRG9vagPoLhJl5Vv/A==
X-Received: by 2002:a17:90a:be0d:: with SMTP id a13mr1339867pjs.84.1561516640089;
        Tue, 25 Jun 2019 19:37:20 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id l2sm14479234pgs.33.2019.06.25.19.37.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 19:37:19 -0700 (PDT)
Date:   Wed, 26 Jun 2019 10:37:13 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: Removing the shared class of tests
Message-ID: <20190626023713.GA7943@desktop>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
 <20190616144440.GD15846@desktop>
 <20190616200154.GA7251@mit.edu>
 <20190620112903.GF15846@desktop>
 <20190620162116.GA4650@mit.edu>
 <20190620175035.GA5380@magnolia>
 <20190624071610.GA10195@infradead.org>
 <20190624130730.GD1805@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624130730.GD1805@mit.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 24, 2019 at 09:07:30AM -0400, Theodore Ts'o wrote:
> On Mon, Jun 24, 2019 at 12:16:10AM -0700, Christoph Hellwig wrote:
> > 
> > As for the higher level question?  The shared tests always confused the
> > heck out of me.  generic with the right feature checks seem like a much
> > better idea.
> 
> Agreed.  I've sent out a patch series to bring the number of patches
> in shared down to four.  Here's what's left:
> 
> shared/002 --- needs a feature test to somehow determine whether a
> 	file system supports thousads of xattrs in a file (currently
> 	on btrfs and xfs)

Another option would be just whitelist btrfs and xfs in a require rule,
we already have few require rules work like that, e.g.
_fstyp_has_non_default_seek_data_hole(), this is not ideal, but works in
such corner cases.

Thanks,
Eryu

> 
> shared/011 --- needs some way of determining that a file system
> 	supports cgroup-aware writeback (currently enabled only for
> 	ext4 and btrfs).  Do we consider lack of support of
> 	cgroup-aware writeback a bug?  If so, maybe it doesn't need a
> 	feature test at all?
> 
> shared/032 --- needs a feature test to determine whether or not a file
> 	system's mkfs supports detection of "foreign file systems".
> 	e.g., whether or not it warns if you try overwrite a file
> 	system w/o another file system.  (Currently enabled by xfs and
> 	btrfs; it doesn't work for ext[234] because e2fsprogs, because
> 	I didn't want to break existing shell scripts, only warns when
> 	it is used interactively.  We could a way to force it to be
> 	activated it points out this tests is fundamentally testing
> 	implementation choices of the userspace utilities of a file
> 	system.  Does it belong in xfstests?   : ¯\_(ツ)_/¯ )
> 
> shared/289 --- contains ext4, xfs, and btrfs mechanisms for
> 	determining blocks which are unallocated.  Has hard-coded
> 	invocations to dumpe2fs, xfs_db, and /bin/btrfs.
> 
> These don't have obvious solutions.  We could maybe add a _notrun if
> adding the thousands of xattrs fails with an ENOSPC or related error
> (f2fs uses something else).
> 
> Maybe we just move shared/011 and move it generic/ w/o a feature test.
> 
> Maybe we remove shared/032 altogether, since for e2fsprogs IMHO
> the right place to put it is the regression test in e2fsprogs --- but
> I know xfs has a different test philosophy for xfsprogs; and tha begs
> the question of what to do for mkfs.btrfs.
> 
> And maybe we just split up shared/289 to three different tests in
> ext4/, xfs/, and btrfs/, since it would make the test script much
> simpler to understand?
> 
> What do people think?
> 
> 						- Ted
