Return-Path: <linux-ext4+bounces-12264-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B18E1CB292E
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 10:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FED830CEF82
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 09:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD76C23E356;
	Wed, 10 Dec 2025 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Zgj6f0Re"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE3239E8B
	for <linux-ext4@vger.kernel.org>; Wed, 10 Dec 2025 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765359148; cv=none; b=pReiEeoUblNatNhQuFcOE1K4ppwnf957Y6T0xSiyTH85dxwdHfcb6ZnXibNaK9Tl8uJhxrT4UbCp1QlVQmecEY3XGjtHQQCl2PFc0Po9SeeqfuG7FCCD62RGOUj07ayOt+wachg/3qqDUqZJEaJfAQyVq9KPDFKZgyhsjjaCZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765359148; c=relaxed/simple;
	bh=8Y8sAlmnlZeVT1aU469lNxFo6NohRlod6a8PP40LnmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rc2a7hZojBPVcVFAlSZoiTPER67yBF6yc5zmRTbccJHS0HOxmgV/YV2EviZr5BF/Pe13QICrM4tKYRLV20KBSdbo63EdqM7puQyKbMWJPutIBdwDmrjD4C30r8+XBmxFlOqPVpbA9qQjXILSVLNLQhwrW8UQCP47ekz9yShP+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Zgj6f0Re; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1765359129;
	bh=YtrgHRKGNLgHp5v47dMZu1Aq3gpaZvcPPEJ8q9A4LAA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=Zgj6f0RekLSJ8h+vTx6Ib3KblNPJ3orBPZZhDDVl8Nk/o5hinxFYmzSVi+esgF3Ak
	 zl2diUEFvlS8pYKZh6w8LOVWTBloTB5Goj+ODJG8IKdKUumW1BfPuKtKZ/UECa8Te8
	 K4ogtiWCAoywKFLI1QSx0iQjagGjcBncwW/HvT00=
X-QQ-mid: zesmtpip4t1765359124t8cf0db81
X-QQ-Originating-IP: WU4nPxF9jI8TcHXgEC66MzzrmnfI7fJKc+rPH+uTkKo=
Received: from winn-pc ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Dec 2025 17:32:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4409227807048412940
Date: Wed, 10 Dec 2025 17:32:02 +0800
From: Winston Wen <wentao@uniontech.com>
To: "Theodore Tso" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: Re: Inquiry: Possible built-in support for longer filenames in ext4
 (beyond 256 bytes)
Message-ID: <2EB6F335572BB77B+20251210173202.58c83465@winn-pc>
In-Reply-To: <20251210090536.GB42106@macsyma.local>
References: <63C71AFEB9EEBDC8+20251210145935.72a6f028@winn-pc>
	<20251210090536.GB42106@macsyma.local>
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
X-QQ-XMAILINFO: Np5KA/LEweiuq8Y849NXeViTQ8TEQRUchd6+R2e1KViFdPiN3vlrxvzx
	z4FDDdRlyXbFUTbhSDqq6F+1FVUqfN78layDCK9F59EvgimOvXqEjJHvRGYYs0ksnzl9Our
	wmX2feUqVQfNIDei9wUc4Cj7J8C55Faw+EEYGluG1L0vMb7Cqh1We4mA3McNVz4nf6KjVO8
	E5e4fPRSZpkSDzuOabFGjHat6Di8MUj/N1iOolNIuN1CaVigAIajvyehx3pGAI4GJxXlVHE
	eumg2vIbcu1NIFxK9KaWRInvDl5Smzx+nsWMxdwxR4v6Qr3SW/0sijS8Tp7kn8uBWfWIeM4
	JNN/vRGQglX+TD4FRG/7o6x2TFaSybEalNCOG1KLkalY9YZgNpbmWdVuJLTSOd+lA46PKVb
	wkMopDl6z+rJ5UCVC6wF60DYPL15Fdup8OYj4jVlDJJMX36mL22FklWjCUlCIdDzJd8Mz3g
	n2IaWM9XQQs/dueVCRo7gztlZgcA1ji2C4Plp7de7YecoF1PmQEVQDYyWX8+dSj4VIWNZ+b
	CDdUReg64r7KLu8gxuQiwpQCRrWLgMKaIYd57r/XR+JtWuZvwz5tde3mAD39oOlGWu1ipXX
	rpFsjgWdl+IKwlqFsqqm2fCEhUWtDUWiD44exNCQoqtd6piDva2FoyuLfkJAdX+oK9uvyCs
	rOnRvCvH5Gp9N6MqrENDJHZuWtnoAtAE8hIJAPuRx2RzhUgQMQfuw1Wk97D8e/rIEnqa6bk
	MYfB9gk35LJySJw8ExUWAuD2SdKcHtoyenFsszM+DoeNx7mVls+iE//3XZsj7LsyDN+OICK
	QuHDxlIdpmeGVb07Va37sDLuoCoaMXpUqvfGAe1aM0uV3rcmoEX2ChUPDVBTZ7mfmhT+U+W
	ugHx73kMWrxJLfrv598KsQ3KTy8nFLjhEJhzPvEkQvkq1VmJbAzxus/nlEF9ykJdpIv9tBs
	Mau4bAH9VfYXxK3D1g5nXgxFv+023qhPCAv0G/xSLAlOSlu4xHTLiPdkdqhuy/u+T9uVr1Y
	0DxWDBW1H1GkYfgkHNreAash6BlHc=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Wed, 10 Dec 2025 18:05:36 +0900
"Theodore Tso" <tytso@mit.edu> wrote:

> On Wed, Dec 10, 2025 at 03:02:11PM +0800, Winston Wen wrote:
> > We are aware that workarounds like wrapfs can be used to support
> > longer filenames, but in practice, this approach is not ideal for
> > seamless user experience. We are therefore curious whether it would
> > be feasible to implement built-in support for longer filenames in
> > ext4 itself. =20
>=20
> I don't think wrapfs can be used to support logner file names, because
> the limitation is quite fundamental.  For example, the glibc
> definition of struct dirent (which is returned by the readdir() system
> call) is as follows (from the man readdir page):
>=20
>            struct dirent {
>                ino_t          d_ino;       /* Inode number */
>                off_t          d_off;       /* Not an offset; see
> below */ unsigned short d_reclen;    /* Length of this record */
>                unsigned char  d_type;      /* Type of file; not
> supported by all filesystem types */
>                char           d_name[256]; /* Null-terminated
> filename */ };
>=20
> So how you might store the longer file name isn't really going to
> help, the problem goes far beyond the question of where this might be
> stored on the file system.
>=20
> 					- Ted
>=20

Hi Ted,

Thank you for your quick and insightful reply.

I apologize if I=E2=80=99ve misunderstood something, but based on our
experience, we have actually implemented and deployed two different
solutions using FUSE and wrapfs in our production environment, both of
which successfully support filenames longer than 256 bytes. This leads
us to believe that the glibc and VFS layers do not impose a hard limit
at 256 bytes in practice.

To better understand, I=E2=80=99ve reviewed the readdir/getdents man pages =
and
the glibc struct dirent definition. It appears that d_name is
implemented as a flexible array member rather than a fixed-size array
of 256 bytes.

Going back to our original question: we were curious whether it might
be possible to support longer filenames natively within ext4 itself
(rather than through FUSE), perhaps via on-disk format extension or
auxiliary storage like xattrs. If this is architecturally feasible, we
would be very interested in exploring it further.

Any further guidance or references you could share would be greatly
appreciated.

Thanks again for your time.

--=20
Thanks,
Winston


