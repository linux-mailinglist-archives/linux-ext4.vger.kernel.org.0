Return-Path: <linux-ext4+bounces-6214-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC28AA1923C
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 14:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833561888F62
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 13:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33767212B2C;
	Wed, 22 Jan 2025 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dUL/3umx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564518E25
	for <linux-ext4@vger.kernel.org>; Wed, 22 Jan 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737551962; cv=none; b=XaOwQsUdYlVoJo82VSIqWL4BGr5i/okewuXwK9PfrvHP4V9mfRriPpQ+wWAYrD9xj2c+Zmqc/WUDtSbyclmgKaMJVhfaUeX3iS2sOOvOvlM/LTQO1xN9yuWGb9PBKXJfC0xUdT1MySO7kJB7Xy45trFE+i8u2iCA/cn54Qt1kUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737551962; c=relaxed/simple;
	bh=rPFLvbqt/uIFqLPJ8njcAiDbXqfG7zrzi50J1Blq8yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWjjgsx1ltptoSp0E/aj2KI27sVSHpPFm1f5Qh3RgUEWggPX4rZMYJG3bjXrq8mMsj22sB/kJxBObNNGAkcPzj+KaCRwh63iKqZ+06n8XQ7MHCod7XR6q0XWSoVNe8DtrBrcg1LwrVFkWl7xTBtYSGUaeAIrxdCiNiAlkNzt5ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dUL/3umx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-161.bstnma.fios.verizon.net [173.48.111.161])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50MDJC2p032427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 08:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1737551954; bh=156SVZ8atIMnQysaqB8KZZQ1NhrpFeJ2W1jRNZKNi40=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=dUL/3umxaBOqMidCfGThiR/X70dutr6KgH1PSMl5g6RwiUm6YXkT6yC7FoxQEkjRE
	 EVddrCb0fsZ58zQv/qbF2+eprhFnIUUZS8ewA+aa0oKoNBGFZc3SbNkUtaxDlMPoB9
	 atWc271HAGX8SyLNhewQZm8MqfSrCkF0lg3qNItDNkAv/Dui2l0gj+mDgeGh/imm6k
	 +UKTQd/BpU2AElK4f7ek0Ff1jONGdnnec9PwY2JVd4tWp+fiyo/Y/Z3d1suPWSK2Rx
	 WAAFKuGKIUJL2iYStX3KkOMy/GN7QNxh8+L1s4JzBsD2zGDTk4hSOFk/76epX4WlGS
	 W11P1rYc8108g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 124C315C01A2; Wed, 22 Jan 2025 08:19:12 -0500 (EST)
Date: Wed, 22 Jan 2025 08:19:12 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Gerhard Wiesinger <lists@wiesinger.com>, linux-ext4@vger.kernel.org
Subject: Re: Transparent compression with ext4 - especially with zstd
Message-ID: <20250122131912.GA3844227@mit.edu>
References: <8cb4d855-6bd8-427f-ac8f-8cf7b91547fb@wiesinger.com>
 <20250121040125.GC3761769@mit.edu>
 <213343dc-3911-45de-8195-469da9dd1a91@wiesinger.com>
 <20250121193351.GA3820043@mit.edu>
 <b8663f69-cdaf-4c05-b99f-cd4105023264@wiesinger.com>
 <Z5CgQosGsbxbbEIL@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5CgQosGsbxbbEIL@infradead.org>

On Tue, Jan 21, 2025 at 11:37:38PM -0800, Christoph Hellwig wrote:
> On Wed, Jan 22, 2025 at 08:29:09AM +0100, Gerhard Wiesinger wrote:
> > BTW: Why does it break the ACID properties?
> 
> It doesn't if implemented properly, which of course means out of place
> writes.
> 
> The only sane way to implement compression in XFS would be using out
> of place writes, which we support for reflinks and which is heavily
> used by the new zoned mode.  For the latter retrofitting compression
> would be relatively easy, but it first needs to get merged, then
> stabilize and mature, and then we'll need to see if we have enough
> use cases.  So don't plan for it.

... but out of place writes means that every single fdatasync() called
by the database now requires a file system level transaction commits.
So now every single fdatasync(2) results in the data blocks getting
written out to a new location on disk (this is what out of place
writes mean), followed by a CACHE FLUSH, followed by the metadata
updates to point at the new location on the disk, first written to the
file system tranaction log, followed by the fs commit block, followed
by a *second* CACHE FLUSH command.

So now let's look at a sample scenario where the database needs to
update 3 different 4k blocks (for example, where you are are crediting
$100 to an income account, followed by a $100 debit to an expense
account, followed by the database commit.

Without transparent compression commits (assuming the database is
properly using fdatasync so it's not asking the file system to update
the ctime/mtime of the database file):

1) random write A (4k write)
2) random write B (4k write)
3) random write C (4k write)
4) CACHE FLUSH

With transparent compression:

1) random write A
2) random write B
3) random write C
4) CACHE FLUSH
5) update the location of compression cluster A written to the fs journal
6) update the location of compression cluster B written to the fs journal
7) update the location of compression cluster C written to the fs journal
8) write the commit block to the fs journal
9) CACHE FLUSH

This kills performance, and as I mentioned, in general, IOPS are
expensive and write bandwidth is often far more expensive than bytes
storage.  This is true both for the raw storage by the cloud provider,
the extra network bandwidth bewteen the host and cluster file system
storing the emulated cloud block device, and amount of money charged
to the cloud customer because it does cost more money to the cloud
provider.

If you try to do transparent compression using update-in-place (for
example, via the technique in the Stac patent) then you don't need to
update the location on disk, but given that you are replacing a 64k
compression cluster every time you update a 4k block, if you crash in
the middle of the 64k compression cluster update, that cluster could
get corrupted --- at which point you break the database's ACID
properties.

Finally, note that both Amazon and Google have first party cloud
products (RDS and CloudSQL, respectively) that provide to the customer
the full MySQL and Postgres feature set.  So if you want to enable
database level compression, I believe you *can* do it.  Compression is
not free, and not magic, but if it works for you, you *can* enable it
if you are using MySQL or Postgres.

Now, if you are using a database that doesn't support database-level
compression, then why don't you try demanding your vendor that is
providing the database to add compression as a feature?  Of course,
they might ask you as the customer to pay $$$, but the development
cost to add new features, whether in the database or the file system,
is also not free.

Cheers,

							- Ted

