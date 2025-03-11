Return-Path: <linux-ext4+bounces-6768-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16494A5D18D
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 22:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419E317CB1C
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 21:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EF0263F31;
	Tue, 11 Mar 2025 21:14:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AD71D6DBB
	for <linux-ext4@vger.kernel.org>; Tue, 11 Mar 2025 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741727661; cv=none; b=k/pV5v9SPPCttMN4Pc5+hz2VJhNk+z+vs4OFK7KCiG3palUfewAoZ/zFfRp6scW4KYlUGfvPZVQgkXC4TIkeV6CxoimpMqzco8mjJ3DWG/+9cTyqQOvCmEHoiYCsjdvjVrxg73/O9dqhRC3FkSIQ43oWRb3ut0iTnzLK21lOfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741727661; c=relaxed/simple;
	bh=FCYNWe3lNar4OL1kQXSUntLlpEfGImEZCm1nQF6VtMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/tZ16seo+qF7IbFjFyJhEakdixE98GqV45E+wkQJ8tx7kUpPbfSYbj5sA+YKE0ss6VWmmYJMa+MQSUblhWc+As2oecfbJDqZV5PSmjJyaidbEaWRwIfoIQsCrlhOG1VWDr5jQKAadkFyif4AavT1oJEaamfGgV6Bwt4f/ZNmvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52BLEBwv011005
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 17:14:12 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 5665C2E010B; Tue, 11 Mar 2025 17:14:11 -0400 (EDT)
Date: Tue, 11 Mar 2025 17:14:11 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Sterba <dsterba@suse.cz>
Cc: "Artem S. Tashkinov" <aros@gmx.com>, linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A syscall for changing birth time
Message-ID: <20250311211411.GA132466@mit.edu>
References: <bda3fa3f-dd12-40de-841a-e4c216ab533f@gmx.com>
 <20250310135828.GB8837@mit.edu>
 <69d8b100-f65d-470f-a957-2819795e82a4@gmx.com>
 <20250310153744.GD8837@mit.edu>
 <20250311160839.GG32661@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311160839.GG32661@twin.jikos.cz>

On Tue, Mar 11, 2025 at 05:08:39PM +0100, David Sterba wrote:
> 
> From my experience and use case: for archiving purposes the creation
> time has a meaning and it gets lost when the files get moved to bigger
> storage. Sometimes the creation is stored in the file metadata (like jpeg
> or video files), but ultimately the creation time is stored in the file
> inode metadata itself regardless of the format.
> 
> Another use case is for send/receive that transfers snapshots from one
> btrfs filesystem to another. In protocol v2 we added the creation time
> (otime) to the stream so the receiving side can read it, but cannot
> write it yet.
> 
> Question about ability to change otime/btime can be found around
> internet, there was attempt to make it a utimensat() operation
> (https://lore.kernel.org/linux-btrfs/cover.1550136164.git.osandov@fb.com).

How about this as a compromise?  We can define in statx two different
timestamp fields.  One is "btime" which is considered forensic
information which is not changeable by a system call interface, and
the other is "crtime" which *can* be changed by a system call
interface.  An individual file system is free to support one, or the
other, or both of these time stamp fields.

So file systems that come from the Windows world, including ntfs,
cifs, vfat, etc. can use crtime, and it can be set via some
standardized interface --- and file systems like xfs that want to
treat it as a non-changeable timestamp can only support btime.

What I might do with ext4 is to add a file system compat flag which
will cause the file system to support either crtime or btime, and
would use the on-dik inode field for one or the other.  That way I
don't break existing file system and potential use cases that want to
use btime, and allow those users who do want to use crtime in some of
the use cases that you've described to do so.  It does mean that a
single file system can only support "btime" or "crtime", but not both,
but it has the advantage that the semantics which are offered by a
particular file system are very clear --- and we don't have to gain
consensus across the various Linux file system maintainers about what
the One True Semantic for "btime/crttime" should be.  We can just have
both.

(And of course, some file systems might only support
mtime/ctime/atime, or only support a single timestamp value, and
that's also fine.)

						- Ted

