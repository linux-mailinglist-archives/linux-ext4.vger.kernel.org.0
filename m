Return-Path: <linux-ext4+bounces-6230-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1ADA1A5D2
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 15:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A007C188996E
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B4520F09D;
	Thu, 23 Jan 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="KCp+WVt5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127141CA8D
	for <linux-ext4@vger.kernel.org>; Thu, 23 Jan 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642982; cv=none; b=DTkaz9DAI7soMLkEhUkIeNYlueCT0J2fOQEtD216+0xKaL5CWpDz+6TVeNaB6OatCyshTf18VPpTqNy+ml3gTRIT0rjDEslzv4ZMcMMUb0PE2Lltd9IIsGP47JbOXrmO19ZMtNoJg4OMMvuJYSO4vjQfkwWCp/v6DlFtOn1qFCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642982; c=relaxed/simple;
	bh=9i78HgaR/K/uMGzsfQEExs0vNgdAY2XGMLXVMvQedVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFWOYbyJtLsbfbcepRsBYL7K6i+Mvi5sLSzf+YAwvOKeeqhoXVuAN7+7R1pyl1xsEvupMauEoFc1jXImZKtYga1sPHXdDkJecxgleH6JvKK+GZ48k30JTskVi4rVopiNj9PzfXczsgBUiWB/0Lz0ULJnVFT+39/0qH0t2ez5fKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=KCp+WVt5; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-111-161.bstnma.fios.verizon.net [173.48.111.161])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50NEa8je031371
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 09:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1737642971; bh=m+K3D6TC8qqwGD93r0vzX6DXE876S+ae4UVvkyiPN10=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=KCp+WVt5LZLvxKU99vF4RW15EVntQFF0WOHuUhnaB9Mx3tbUEuAT+ZBMkCE7QL6a8
	 UAEXBXWauBervjFyyVD+8x+1cYluh6YqGmOp1xJLR9Q47wHPJDE2eIS/apgb0/r0Yo
	 XM015xVDDJ0RyhQj4Bic8cmbAMwkmAqWdMCPfwhDJ/QOXaZ9ytpCZwQpatB7k5IF4C
	 bTiT3mltqQWNQCnwSBbtt7+Lwrx1NSlu6Ss2P2o4q3qHmreqeFEOe69Jf5GIZJtT2K
	 n2x12JnHC8yHJ4/zUTtPDkWS1FYBifdjiIrsFFEC5vG67CHuTWge98VojwJU+myiBc
	 +opRrUKoqroOA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id BB17715C011B; Thu, 23 Jan 2025 09:36:08 -0500 (EST)
Date: Thu, 23 Jan 2025 09:36:08 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?utf-8?B?5p2O5rqi5p6X?= <liyilin22@mail.sdu.edu.cn>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: Security Vulnerability Report: Cross-filesystem ACL Permissions
 Issue in Different File Systems (EXT4, XFS, NTFS, etc.)
Message-ID: <20250123143608.GC3875121@mit.edu>
References: <ADQA5wAlItaWspfgpQyP3qot.1.1737622470288.Hmail.202217060@mail.sdu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ADQA5wAlItaWspfgpQyP3qot.1.1737622470288.Hmail.202217060@mail.sdu.edu.cn>

On Thu, Jan 23, 2025 at 04:54:30PM +0800, 李溢林 wrote:
> I am writing to report a security vulnerability related to
> cross-filesystem permissions management that I have discovered. This
> issue appears to impact filesystems like EXT4 and XFS, and it could
> potentially lead to unauthorized access of sensitive data during the
> migration of files between different filesystems with varying
> permission models.
>
> The vulnerability arises when a file with Access Control List (ACL)
> restrictions, created in a file system that supports ACL (e.g., EXT4
> or XFS), is moved or copied to a file system that does not support
> ACL (e.g., FAT32 or NTFS). During this migration, the ACLs are lost,
> and the file's permissions fall back to default settings on the
> target file system, which may allow unauthorized users to access the
> file.

What is your proposal for how to address this?  I'm not really sure
I'd call it a "vulnerability", per se.  If the user is relying on a
particular ACL to deny access using negative access, and they copy the
file somewhere that doesn't support Posix ACL's, this is the natural
and expected effect.

There are plenty of ways this could happen beyond the one that you've
describe.  For example, they could copy the file to a file system that
doesn't support ACL's at all (such as say a FAT file system).  They
could create a tar file.  They could use rsync or scp to copy the
directory hierarcy, etc.

Further, I'll note that NFS (sometimes fondly referred to by security
folks as "No File Security") relies on the client asserting the user
id accessing the file.  (Yes, in theory NFS could use Kerberos or
GSSAPI to provide user-level authentication, but in practice, this is
**extremely** rare.)  Furthermore, the system administration policies
of the client might very well be different from the server.  For
example, users might have physical access to the client, making it
trivially possible to gain root, where as the server might be in a
locked machine room.

For example, consider how we used Kerberos authentcation, NFS, and the
fact that users could trvially get root on their local clients[1] at
MIT Project Atenna back in the late 1980's.

[1] https://minnie.tuhs.org/mailman3/hyperkitty/list/tuhs@tuhs.org/thread/QB6D2L2RGO5C3BYT45RSEXKLICQYGOSF/#RYYRCWE247SEU7TGN7IPATYK3GZHGX36


I'll also note that in general, the scenario assumes that files are
accessile via local file access as well as remotely over some kind of
remote file accesss (e.g., CIFS or NFS).  Don't do that.  If you are
trying to supply access to legacy Windows machines using CIFS, then
access the files from Linux using CIFS as well, and then rely solely
on the Windows ACL model.  Otherwise, even if the files aren't getting
copied, the access checks when the files are access locally are
different from when they are accessed via some kind of remote access
protocol, whether it's a remote file system like NFS, or something
like WEBDAV.


> This issue is critical when files are transferred between file
> systems with incompatible ACL implementations, particularly in
> multi-user or shared environments. I have tested this behavior on
> multiple systems, and it is clear that moving files between file
> systems with different ACL models leads to unintended permission
> changes.

I the user is copying it from a file hiearchy using Posix ACL, to a
different file system hierarchy, then how is that different from the
"security vulnerability" where the user copies it to a USB thumb
drive, and then takes the USB thumb drive out, and hands it to a spy?
Oh, noes!!!

Fundamentally, if you don't trust the user (either because they might
be malicious, or because they are incompetent), Discretionary Access
Controls (DAC) are not going to help you.  This is why Mandatory
Access Controls (MAC) were invented.  Of course, MAC's are extremely
painful to use, and so in practice almost no one tries to use MAC
today.  Military organizations might use it if they have unlimited
budget, but even there, it's often easier to have separate systems for
unclassified informations and for classified information, and you
control physical access via armed guards and the signs saying "Deadly
Force is Authorized".  :-)

Cheers,

					- Ted

