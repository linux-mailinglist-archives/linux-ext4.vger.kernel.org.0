Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D0B2AA89E
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Nov 2020 01:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgKHAlA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Nov 2020 19:41:00 -0500
Received: from mout.gmx.net ([212.227.17.20]:36341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgKHAk7 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 7 Nov 2020 19:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604796053;
        bh=mWjJ0DimkQwVS54NM2sHgfMoe5IdgjJ/+4WF1B+qSqk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Tw2DfqbjweXEwICfxJl5BtYyA0Uhmhhy5iOAQ5SORJ4kcEUPk+zqw8ClmmOJcSN3Y
         hYTi5H4+XEA/m6x8kLCEeNVO6KoJemeR42vJ3duqWNlB3qKQQB3jLP77JxmDsCWtjj
         qadyZ4JMBZyQ57k0YA6tTyhp0LCZ0e6t3wJMKM4o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zFj-1kEtDK2wGx-01550s; Sun, 08
 Nov 2020 01:40:53 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-doc@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jan Kara <jack@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: filesystems: Reduce ext2.rst to one top-level heading
Date:   Sun,  8 Nov 2020 01:40:45 +0100
Message-Id: <20201108004045.1378676-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FrMulFltGVWOjEpimVwcelAsU54AfJhW7agEtWJr3SUQ6i/FENY
 IsEZuhmLJmtq7HLKvlDZTC7GErNatFT+tBBLwkdNPQwuXhFNMk5VKBDzD63ahnJhc4jmA8b
 52gqZkKIFj4EShMxt/q6jzJQG+QulT02AP0U0i1zDWkth5p9z+/pSjHWrjcqfCdZkbB+5v6
 JYSPDXK+74a3nzHNBuF2Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yxo3+nVz7NI=:qnGx4iHfeeuwuMGNDE7hYE
 e5MJvWmsFUTzJM9TqZuW8vfel8ty+P1Daswlu7l369/PSvLytbMQjhr5XHzQAj5WuU7WiyDBe
 K59LizNUBEwICICgg08attubAoHTTZ5WjRS9Mw1BwWQmLo2QJMXKa28joR0r/v42Xyb+Ecd/B
 rvtsG1eAnyP8RiVrgUo6o4T8lqFu2YGKSbL0XMGYR1vEm9KScSf8+NOelaLCuFHLedchBV86m
 p/RpFu8gg9j7OgG149R2qbK+/JabqHc//Xdmu1oQEvYCgqvGPldr3kyAVRM4lSHq1UEcUyUZU
 2GzPxYG/DM236++Rb7WfffuUNyDweeZup8rfJ4CesUdSvL3orPq+plMrkU8SAXHLWNiBynNeI
 rY27V9l2VecvbWlePW9mh8SYHFj48SlhTxG+42ez5Nt8hZ4X/EcELOgXDv669/pw3FtSQyIhR
 aJFNg21fl6r/iDWoJYWMWyTuDx/pE+szsu/wfHXlfkPhlZPxg4u4DPVd7RewxvcE4oGlnaaZM
 sTm86F/Q3BOhFh0QEP7PLB0hUbpD7aFTvn+fULqdPtEMVPODT02cwOx3s+2CHLQU2OGS+QoH8
 H+I5tyomYIo9HBG+a8GrjiNtLW3drEjOUb7d9tteTfFvPLXn+xFpvc/Jz5+KGUsev1KR8sXqY
 Z2/g4R6GBYuOQbY4rYQIUyd8RGjX/gFORfSiyfsfXak9fTw1IZDsa3iUzq5ki+jClwhqXgGZh
 iOstyHJsykJZDlEdq7wk9xAu52JcVbG5BcdXVhYB8InVHiFMAQIj27nTn+IliIpiFXHM9msDY
 LxFSQzvpCvFVKPZUQBicneRyEkXhAbxF/AnZXngpAUK9vzenMGt8pe9e/EyE9DsO+Uv4XXmJO
 ifdk5e8KI7CscBzCHJcUPh8h3uNgKw9IJYdqYEUH4=
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This prevents the other headings like "Options" and "Specification" from
leaking out and being listed separately in the table of contents.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 Documentation/filesystems/ext2.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/filesystems/ext2.rst b/Documentation/filesystem=
s/ext2.rst
index d83dbbb162e20..c2fce22cfd035 100644
=2D-- a/Documentation/filesystems/ext2.rst
+++ b/Documentation/filesystems/ext2.rst
@@ -1,6 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0


+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
 The Second Extended Filesystem
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

=2D-
2.28.0

