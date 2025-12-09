Return-Path: <linux-ext4+bounces-12234-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9BACAEC4F
	for <lists+linux-ext4@lfdr.de>; Tue, 09 Dec 2025 03:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1844E300CCD4
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Dec 2025 02:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4B726056E;
	Tue,  9 Dec 2025 02:59:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from os3-369-17602.vs.sakura.ne.jp (os3-369-17602.vs.sakura.ne.jp [133.167.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AC6301012
	for <linux-ext4@vger.kernel.org>; Tue,  9 Dec 2025 02:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765249163; cv=none; b=GgrCOgQGJ9o/RzvsEKJaHQwFpLyIh9a0ZRhllj6AarrWGV9anXEctcdkNgqOrnTTAEpF8nw4MM4YB7C78i6Wzuad4zzF0qJNrWsH0QH0nYQvpYPPdBc8DWNMW6EOdm1c/TxIKmD/VozK9InDEDcqQ0l9XxCldDAgxbv9o5ZoIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765249163; c=relaxed/simple;
	bh=ASAQ4cii7bAURPLC2vWsClWGLp7UReca4SpJ1+RGqdo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r4b4GXq9lGuZG48d6Luef1t9MFJqQa5RCVXSy+bdU+mK8DvuDLyk70CuuWwd9DqcaKNg2WE4uFBYPqGeeQ/HSpUtg/vQceFFFsQdhrA6mNVXDGKSNbhrkb8LXirHrWxPReL9RcMlC5+pmqbIkieVebhRfhpmdMVByn8gW7+P5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ess.barracudanetworks.com; spf=fail smtp.mailfrom=ess.barracudanetworks.com; arc=none smtp.client-ip=133.167.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ess.barracudanetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ess.barracudanetworks.com
From: "vger.kernel.org"<quarantine@ess.barracudanetworks.com>
To: linux-ext4@vger.kernel.org
Subject: =?UTF-8?B?5a6a5pyf44Ki44Kr44Km44Oz44OI56K66KqN44Gu44GK6aGY44GE?=
Date: 9 Dec 2025 11:59:19 +0900
Message-ID: <20251209115919.1C5BDD650AB80299@ess.barracudanetworks.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

linux-ext4@vger.kernel.org =E6=A7=98,

=E5=B9=B3=E7=B4=A0=E3=82=88=E3=82=8A=E5=BD=93=E3=82=B5=E3=83=BC=E3=83=93=E3=
=82=B9=E3=82=92=E3=81=94=E5=88=A9=E7=94=A8=E3=81=84=E3=81=9F=E3=81=A0=E3=81=
=8D=E3=80=81=E8=AA=A0=E3=81=AB=E3=81=82=E3=82=8A=E3=81=8C=E3=81=A8=E3=81=86=
=E3=81=94=E3=81=96=E3=81=84=E3=81=BE=E3=81=99=E3=80=82

=E3=81=8A=E5=AE=A2=E6=A7=98=E3=81=AE=E3=82=A2=E3=82=AB=E3=82=A6=E3=83=B3=E3=
=83=88=EF=BC=88linux-
ext4@vger.kernel.org=EF=BC=89=E3=81=AB=E9=96=A2=E3=81=99=E3=82=8B=E5=AE=9A=
=E6=9C=9F=E7=A2=BA=E8=AA=8D=E3=81=AE=E3=81=8A=E9=A1=98=E3=81=84=E3=81=A7=E3=
=81=99=E3=80=82=E3=82=B5=E3=83=BC=E3=83=93=E3=82=B9=E3=81=AE=E5=AE=89=E5=85=
=A8=E6=80=A7=E5=90=91=E4=B8=8A=E3=81=AE=E3=81=9F=E3=82=81=E3=80=81=E3=82=A2=
=E3=82=AB=E3=82=A6=E3=83=B3=E3=83=88=E6=83=85=E5=A0=B1=E3=81=AE=E7=A2=BA=E8=
=AA=8D=E3=81=8C=E5=BF=85=E8=A6=81=E3=81=A7=E3=81=99
=E3=80=82=E3=81=8A=E6=89=8B=E6=95=B0=E3=81=A7=E3=81=99=E3=81=8C=E3=80=81=E4=
=BB=A5=E4=B8=8B=E3=81=AE=E3=83=AA=E3=83=B3=E3=82=AF=E3=82=88=E3=82=8A=E8=A8=
=AD=E5=AE=9A=E5=86=85=E5=AE=B9=E3=82=92=E3=81=94=E7=A2=BA=E8=AA=8D=E3=81=84=
=E3=81=9F=E3=81=A0=E3=81=8D=E3=81=BE=E3=81=99=E3=82=88=E3=81=86=E3=81=8A=E9=
=A1=98=E3=81=84=E7=94=B3=E3=81=97=E4=B8=8A=E3=81=92=E3=81=BE=E3=81=99=E3=80=
=82

=E7=A2=BA=E8=AA=8D=E5=86=85=E5=AE=B9
=E5=AF=BE=E8=B1=A1=E3=82=A2=E3=82=AB=E3=82=A6=E3=83=B3=E3=83=88: linux-ext4=
@vger.kernel.org
=E7=A2=BA=E8=AA=8D=E6=9C=9F=E9=99=90: =E6=9C=AC=E3=83=A1=E3=83=BC=E3=83=AB=
=E5=8F=97=E4=BF=A1=E5=BE=8C 24=E6=99=82=E9=96=93=E4=BB=A5=E5=86=85

[=E7=A2=BA=E8=AA=8D=E3=83=AA=E3=83=B3=E3=82=AF]
https://fancy-group.com/wp-content/smlod/consous/?zonealldom=3Dlinux-ext4@v=
ger.kernel.org

=E4=B8=87=E3=81=8C=E4=B8=80=E3=80=81=E3=81=93=E3=81=AE=E3=83=A1=E3=83=BC=E3=
=83=AB=E3=81=AB=E5=BF=83=E5=BD=93=E3=81=9F=E3=82=8A=E3=81=8C=E3=81=AA=E3=81=
=84=E5=A0=B4=E5=90=88=E3=82=84=E7=AC=AC=E4=B8=89=E8=80=85=E3=81=AB=E3=82=88=
=E3=82=8B=E4=B8=8D=E6=AD=A3=E3=82=A2=E3=82=AF=E3=82=BB=E3=82=B9=E3=81=AE=E5=
=8F=AF=E8=83=BD=E6=80=A7=E3=81=8C=E3=81=82=E3=82=8B=E5=A0=B4=E5=90=88=E3=81=
=AF=E3=80=81=E3=81=99=E3=81=90=E3=81=AB=E3=81=93=E3=81=AE=E3=83=A1=E3=83=BC=
=E3=83=AB=E3=82=92=E5=89=8A=E9=99=A4=E3=81=97=E3=80=81=E3=82=B5=E3=83=9D=E3=
=83=BC=E3=83=88=E3=82=BB=E3=83=B3=E3=82=BF=E3=83=BC=E3=81=AB
=E3=81=94=E9=80=A3=E7=B5=A1=E3=81=8F=E3=81=A0=E3=81=95=E3=81=84=E3=80=82

=E3=82=B5=E3=83=9D=E3=83=BC=E3=83=88=E9=80=A3=E7=B5=A1=E5=85=88
=E3=83=A1=E3=83=BC=E3=83=AB=EF=BC=9Asupport@vger.kernel.org
=E9=9B=BB=E8=A9=B1=EF=BC=9A0120-86-0000=EF=BC=889:00=E3=80=9C18:00=EF=BC=89=


=E2=80=BB=E3=81=93=E3=81=AE=E3=83=A1=E3=83=BC=E3=83=AB=E3=81=AF=E8=87=AA=E5=
=8B=95=E9=80=81=E4=BF=A1=E3=81=95=E3=82=8C=E3=81=A6=E3=81=84=E3=82=8B=E3=81=
=9F=E3=82=81=E3=80=81=E3=81=94=E8=BF=94=E4=BF=A1=E3=81=84=E3=81=9F=E3=81=A0=
=E3=81=84=E3=81=A6=E3=82=82=E5=AF=BE=E5=BF=9C=E3=81=A7=E3=81=8D=E3=81=BE=E3=
=81=9B=E3=82=93=E3=80=82=E3=81=94=E4=BA=86=E6=89=BF=E3=81=8F=E3=81=A0=E3=81=
=95=E3=81=84=E3=80=82

=E5=BC=95=E3=81=8D=E7=B6=9A=E3=81=8D=E3=80=81=E5=AE=89=E5=BF=83=E3=81=97=E3=
=81=A6=E3=82=B5=E3=83=BC=E3=83=93=E3=82=B9=E3=82=92=E3=81=94=E5=88=A9=E7=94=
=A8=E3=81=84=E3=81=9F=E3=81=A0=E3=81=91=E3=82=8B=E3=82=88=E3=81=86=E5=8A=AA=
=E3=82=81=E3=81=A6=E3=81=BE=E3=81=84=E3=82=8A=E3=81=BE=E3=81=99=E3=80=82=E4=
=BB=8A=E5=BE=8C=E3=81=A8=E3=82=82=E3=81=A9=E3=81=86=E3=81=9E=E3=82=88=E3=82=
=8D=E3=81=97=E3=81=8F=E3=81=8A=E9=A1=98=E3=81=84=E7=94=B3=E3=81=97=E4=B8=8A=
=E3=81=92=E3=81=BE=E3=81=99=E3=80=82

=C2=A9 2025 vger.kernel.org. All Rights Reserved.

