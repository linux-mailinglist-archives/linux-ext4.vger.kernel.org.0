Return-Path: <linux-ext4+bounces-12281-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E0DCB46DE
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 02:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29D9D3056C53
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 01:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C5024DCE5;
	Thu, 11 Dec 2025 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Pxf/lE3Z"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BFB24A069
	for <linux-ext4@vger.kernel.org>; Thu, 11 Dec 2025 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765416094; cv=none; b=RpseRY7TlYzpxKazUEVL5Hzngu+GZ/1dRqIgrAxJvNO4UknG2gZmC16Fj+ArYChjPT0OpYm7+fVVsaH8JIpdwxseyt3qiHPI9laqo8i3J4ZMkX0HfuBL13tn2pDZFreMhLbix3pKg/tY2qXzuQlKx9y9sHWQuW99aJRoVd2tes0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765416094; c=relaxed/simple;
	bh=PHx+V/+p9rUd9QZy682AqHruGWrESgs4e4skmlkK+Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQYoDbp9cCDOF+TgBRO26ZDmHQYBigsYi4p0UsvZcfpg7cmpu+j/GUOsBrsI2GBiZgl5jwSpCYMcTWGq/8CAX0iGKf35kvQDdRFdmxNpL5DDm89OvHPN3qwuf7UA7tF5RNdQ1mt1HgVX7lo30pWnY/6U5eGs5nXnKjKaPxbN0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Pxf/lE3Z; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1765416073;
	bh=dRXPLe+xqadQHciP4R/RIWexVMCFfeNjgd69uh7/pwA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=Pxf/lE3ZE8XbmY4Jng3A0nls538hd6Yw3msVQ71+pjEDNTCY9tBHyfrxDyZOdu2fs
	 lpNXZc46a9zIHCG2j/o5Lm9aZqAIQXsrYhIL61+nlVvDEbhhFIoWHmZiySrazNIK9M
	 RTkOtjG0ujm3wUmzR2GyyTjrExZrz03rZidfbtHs=
X-QQ-mid: zesmtpip3t1765416068t451f478e
X-QQ-Originating-IP: rE8VXQ7cD9Wju3DzqcSMYuHVuhJUMhx78tXmV7kDD2w=
Received: from winn-pc ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Dec 2025 09:21:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10552885622849482009
Date: Thu, 11 Dec 2025 09:21:06 +0800
From: Winston Wen <wentao@uniontech.com>
To: "Theodore Tso" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: Re: Inquiry: Possible built-in support for longer filenames in ext4
 (beyond 256 bytes)
Message-ID: <EAC144C5F16D12E1+20251211092106.38127aec@winn-pc>
In-Reply-To: <20251210232459.GD42106@macsyma.local>
References: <63C71AFEB9EEBDC8+20251210145935.72a6f028@winn-pc>
	<20251210090536.GB42106@macsyma.local>
	<2EB6F335572BB77B+20251210173202.58c83465@winn-pc>
	<20251210232459.GD42106@macsyma.local>
Organization: Uniontech
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: NTMm76RsSGXEbLrxuTSqr+Ij8UOmjNbF1r7ZEmRn726axS//q/vjnyQp
	8BNF6LR1VRChasr5TXbL23Yt5GamgODogcYOBi+xMOjpqWm0GasfDq/IY10JsO2zndlDchQ
	Vbn6QemG0T2QDzHGKxsTj2f/cLLDhxegnnRmxH2rxcXzg4sgdoavTFDC/UO+YrYjOARlw2d
	BmgyDjsz19mSyidXRNOkc3GzXCapBzk+FRyCGnhGKlO3d/SpdB2BWq46SrKfkKp88pMhPHA
	j5JbN41xoFCiBfZw9i37OnHVz/D0J7UZ6pVK8x5g8hGE2AwZJTd/UZaBBNNAWRmLuLF3e1r
	n14V1JuZlZZhHKlFsS1MUto26PKnpgiJtMl6zZJ+xMImCPYW/u0D69SoP6IUFiiuFepk1RS
	SxHduoxOFb3gwPvcxUAG7cSlZIbYYbj/45+/dGzxuM3kCAJBafH4rDlX3n0VqaBFBJcZ/Ri
	qCmgyixipvmIeOylcWZuYoMCj655mucc9OgvmTuIDcV5w4KpX5i8Z8IBn1TiPsLMM8SnfL7
	PmXtPUjZ2W65/Lmj76amwazQzZcvJ9usBFItktBsGtlHlHjt0ihY/LG3BYre2V/HdyL7uLd
	QrKxJmipiRTn3+48S0cy6Js4pTE9pS7YLnHhtWh87Jzu++0DvfPJJDE+TLnqJrrsYm2dwGn
	2bEJfHcRFx/xs8XBoXvGE/HvYivWcO73vP1CSSUVlbfjkFRUXX9e2gZzTv5+cZyNeTcTEgN
	wurcGGtbWMDs9kw6FsnE7uPbSvFMF7YqMN55ONbInNiPxARkuzhdpddWW/755c8S3evToh3
	vThqe0RwQ9TbeXJkCL+F7W1RKixTb4dpV0C7zNomfCesLfpSf8E+KvjH7JhCRkqKGa+WgcL
	jjDyiY+sdSpdfM4BJeZ+ojcBX/+/WeM0w5SWdXwvZXlSTcwO4p23bqC9dF/uIplysxaAAnt
	D9vweMLaHXYMOuiFhRHCGuz4w3Abt1DokEYsos+UaksxSYV8ltVABxA6VbGKbRmoOAaeFOg
	XZCml2XZJMW5+HP+U7hiP6vzUroMT9XhsR3LiPXg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Thu, 11 Dec 2025 08:24:59 +0900
"Theodore Tso" <tytso@mit.edu> wrote:

Hi Ted,

Thank you for your detailed and thoughtful response. Your insights are
greatly appreciated.

> On Wed, Dec 10, 2025 at 05:32:02PM +0800, Winston Wen wrote:
> > To better understand, I=E2=80=99ve reviewed the readdir/getdents man pa=
ges
> > and the glibc struct dirent definition. It appears that d_name is
> > implemented as a flexible array member rather than a fixed-size
> > array of 256 bytes. =20
>=20
> Intresting; the struture definition I quoted was from the readdir man
> page.

Indeed, the readdir.3 man page does show the definition you quoted. The
actual implementation in glibc headers and the readdir.2/getdents.2
system call interface uses a flexible array, as you noted.

>=20
> I suspect there may be some number of random failures that might occur
> because of hidden dependencies on the historical / traditional value
> of NAME_MAX.  For example, it might be OK for glibc; but what about
> other C libraries that ship on Linux, such as musl, dietlibc, bionic,
> etc.?
>=20

This is a valid concern. We have not tested with other C libraries such
as musl, dietlibc, or bionic. In our use case, primarily file migration
and document management operations, we have been using FUSE or wrapfs
to mount specific directories on demand, rather than entire home
directories. This has worked for our limited scope.

Your point also reminds me that seeking universal support may not be
the right path. NAME_MAX has been around for a long time, and many code
paths may depend on it in ways we haven=E2=80=99t encountered yet.

> > Going back to our original question: we were curious whether it
> > might be possible to support longer filenames natively within ext4
> > itself (rather than through FUSE), perhaps via on-disk format
> > extension or auxiliary storage like xattrs. If this is
> > architecturally feasible, we would be very interested in exploring
> > it further. =20
>=20
> Well, extended attributes won't work, because xattrs are associated
> with the inode, not the directory entry.  So you need to handle cases
> where the file has multiple hard links.  And if you are doing a lookup
> by long file name, there's a chicken and egg problem; you can't match
> against the full filename until you read the xattr, and you can't do
> that until you've lookup.
>=20

Understood, that makes sense. Thank you for explaining the fundamental
limitation with xattrs.

> The only way to do this would be to make an incompatible change to the
> directory layout.  And doing this would require either refactoring and
> doing extensive rework of the code in fs/ext4/namei.c and
> fs/ext4/dir.c, to support both the the original v1 version of the
> directory layout, and the v2 version of the directory layout, as well
> as handling the v2 verison of the directory when it is encrypted.
> It's _doable_, but it's a huge amount of work.  So the question is
> whether it's worth it.  If this is some random class project where you
> don't care about bugs or reliability, that's one thing.  If this is
> something that need to be hardened for production usage, it's quite a
> lot more work.
>=20

I completely agree. Changing the on=E2=80=91disk format would indeed be a
massive undertaking and far beyond our current capacity. It would also
introduce stability and compatibility risks that we are not prepared to
take. Given that, we will likely not pursue this direction.

> Why are you interested in doing this?  Is there business justification
> such that your company would be willing invest a significant amount of
> effort?

This is actually an interesting point. Personally, I=E2=80=99ve never hit t=
his
limit in my own Linux usage, 80 Chinese characters is far more than I
typically need. However, many of our customers work with official
documents (e.g., government or enterprise paperwork) where filenames
regularly exceed this limit. So the requirement comes from real=E2=80=91wor=
ld
business projects.

That said, because the need is mostly confined to document directories,
we can continue to use FUSE or wrapfs for targeted support, even though
it introduces some usability overhead. It=E2=80=99s a workable solution for=
 our
specific scenario.

>=20
> Cheers,
>=20
> 						- Ted
>=20

Thank you again for taking the time to explain the technical and
practical constraints. Your guidance has been very helpful.

--=20
Thanks,
Winston

