Return-Path: <linux-ext4+bounces-8773-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5746AF5B41
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 16:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7A416F0CD
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 14:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E1E307ADA;
	Wed,  2 Jul 2025 14:38:10 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B892139D
	for <linux-ext4@vger.kernel.org>; Wed,  2 Jul 2025 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467089; cv=none; b=DsQEjLrrFP9bP3sFiUhbu3zhHDKS2rAvprxv06KUVk2YfqEQzlf0sStqIDFDQwfryKtoojYhhsraW9ukDd5aEUmkNFSqeP3UkxDxEKdsLRI9ae0/4vUo1LFo128+z+uSswVfVD2S2WHeP+TuyznVUAsEqceqoeP3VTQPQFPGii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467089; c=relaxed/simple;
	bh=3tKFmP88vJhrmRqzdpOmMc/BnWkuG5vwj+te895p6O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4Aj6N1UmWDmeqMkIDmPdsEUUk8ARlViYKJlkZfhUQNRl+kQUyCevGbdnt65+1PAPb5sOYVY5SERxzE84o8e1tn9aFKKNf4/urgc5iDvMyr2U9QdBTaHRDhMFsr47qM6sSsYn1Vxs/muBZCpOwnfYHgyg1tTecUmsfR5yICsrn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-121.bstnma.fios.verizon.net [108.26.156.121])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 562EbtDh031950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Jul 2025 10:37:55 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 4AEE32E00D5; Wed, 02 Jul 2025 10:37:55 -0400 (EDT)
Date: Wed, 2 Jul 2025 10:37:55 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jean-Louis Dupond <jean-louis@dupond.be>
Cc: linux-ext4@vger.kernel.org
Subject: Re: ext4 metadata corruption - snapshot related?
Message-ID: <20250702143755.GB3471@mit.edu>
References: <e90d9c7f-adf8-453d-a3c2-f1d28ee9d9b3@dupond.be>
 <7b9c7a42-de7b-4408-91a6-1c35e14cc380@dupond.be>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b9c7a42-de7b-4408-91a6-1c35e14cc380@dupond.be>

On Wed, Jul 02, 2025 at 03:43:25PM +0200, Jean-Louis Dupond wrote:
> We updated a machine to a newer 6.15.2-1.el8.elrepo.x86_64 kernel, and the
> same? bug reoccurred after some time:
> 
> The error was the following:
> Jul 02 11:03:35 xxxxx kernel: EXT4-fs error (device sdd1): ext4_lookup:1791:
> inode #44962812: comm imap: deleted inode referenced: 44997932
> Jul 02 11:03:35 xxxxx kernel: EXT4-fs error (device sdd1): ext4_lookup:1791:
> inode #44962812: comm imap: deleted inode referenced: 44997932
> Jul 02 11:03:35 xxxxx kernel: EXT4-fs error (device sdd1): ext4_lookup:1791:
> inode #44962812: comm imap: deleted inode referenced: 44997932
> Jul 02 11:04:03 xxxxx kernel: EXT4-fs error (device sdd1): ext4_lookup:1791:
> inode #44962812: comm imap: deleted inode referenced: 44997932
> 
> Any idea's on how this could be debugged further?

If it's correlated to snapshots, then I'd certainly be trying to
looking at potential bugs on the hypervisor.  We've also had a bug
where people were trying to look at bugs on the guest kernel, but the
bug ended up being root caused to a bug on the host kernel.

If moving from 4.18 Cloudlinux 8 kernel to a 6.15.2 RHEL8 kernel shows
the same problem, then it does suggest that the problem isn't with the
guest kernel, but rather in the part of the setup which didn't change
(e.g., the host kernel and hypervisor).

Without a whole lot more details about what your workload might be,
what the host OS software might be, etc., it's really hard to make any
further suggestions.  Are you running this on some kind of cloud
infrastructure (e.g., Microsoft Azure, Amazon AWS, Google Cloud, etc?
Something else?  Have you tried running your workload on some kind of
alternate infrastructure and see if the problem gets solved if you use
a different Cloud provider?

						- Ted


