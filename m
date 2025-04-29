Return-Path: <linux-ext4+bounces-7546-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C640AA1193
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 18:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5231192435C
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3661F22A7EB;
	Tue, 29 Apr 2025 16:32:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2352746A
	for <linux-ext4@vger.kernel.org>; Tue, 29 Apr 2025 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745944321; cv=none; b=JgXx5rI/4cgiChws8FKbN9bCw5vr9HLK7VyrTOwprAGCKKrDRGRRTEfyqyf8fNKcGD5V4UX8aRxJLICTluDge1y6ln2Q05j77I36ggvg0U1LrN62Awv8wa5X9YtHH9jyX3VQ7MiX7CTnSTB3kgdJ9B11Fd/QtHBu8xYVUxLSqF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745944321; c=relaxed/simple;
	bh=dCZbE6sS4JaEfXIsDbutDw7KKu7B+DLu7uXoSO9HnZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lewAMWBh0G8e8tSkc8tkUvjWWaSRzxHSvHupAQPZzNyEWz9QzRVaEF4hFWMRVLg0R13r7dZeLXPmj9Wq1SuMflc6VMbEgx7vG+OtLCsrB/MryTE3ty4BPUzLTiefXVqukLKH2S4IyuzeBmBBxrxHWTqHn31GyemhMsVS6qRXkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-201.bstnma.fios.verizon.net [173.48.112.201])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53TGVnxE009517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 12:31:49 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E278D2E00E9; Tue, 29 Apr 2025 12:31:48 -0400 (EDT)
Date: Tue, 29 Apr 2025 12:31:48 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Zakrzewski <jozakrzewski@microsoft.com>
Cc: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Question about fsck for ext4
Message-ID: <20250429163148.GA3354408@mit.edu>
References: <DS1PR21MB4166208B2E5F4D23F547E349DF802@DS1PR21MB4166.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS1PR21MB4166208B2E5F4D23F547E349DF802@DS1PR21MB4166.namprd21.prod.outlook.com>

On Tue, Apr 29, 2025 at 01:25:35PM +0000, John Zakrzewski wrote:

> Hi! We are using the k8 utils opensource
> project(https://github.com/kubernetes/utils) and looking for your
> thoughts on an issue where fsck is being run on every remount and if
> this is necessary for journaling filesystems.  Eric Sandeen's
> comments
> here(https://github.com/kubernetes/utils/pull/132#issuecomment-605492335)
> indicate it is not but wanted to verify with you that his statements
> apply to ext4 as well.  Ultimately I am looking for reassurance to
> relax the need for fsck on mounts for ext4.  I look forward to
> hearing your thoughts and please don't hesitate to ask clarifying
> questions. Thank you!

Normally, when you run fsck.ext4 on a file system with journalling
enabled, all fsck.ext4 will do is replay the journal.  This is fast,
and the advantage of doing this by fsck as opposed to replaying the
journal at mount time is if you have multiple spindles (HDD's),
/sbin/fsck will run multiple /sbin/fsck.ext4 in parallel, while
/sbin/mount -a will run the mounts sequentially, leading to the
journals being replayed sequentially.

XFS doesn't have the capability of replaying the journal in userspace,
so this is an advantage of ext4 --- although XFS uses logical
journalling so usually the time to replay the journal is smaller than
ext4's physical journalling, so the disadvantage of replaying the
journal sequentially versus in parallel is not that big of a deal for
XFS.

The other advantage of running fsck on the file system is if the
kernel discovers a file system inconsistency, it will set a flag
indicating that fsck should do a full check.  If you skip running fsck
at boot, then this automatic correction happen.  Of course, this
shouldn't be an issue if you are 100% certain that there are no
hardware faults, and no kernel bugs.  :-)

However, if the file system is not marked as having inconsistencies,
then the time to replay the journal is in general only a few seconds
if you are using a HDD, and less than a second if you are using a SSD.
And if the journal has already been replayed, running fsck -p on a
file system is super fast (well under a second), so long as the file
system is error-free.

So I'm not sure it's worth it for you to "relax the need for running
fsck", because the time to run fsck is quite short.

Now, if you are seeing that the fsck time is non-trivial, you should
investigate why that is the case.  Because that is definitely not
normal.

						- Ted

