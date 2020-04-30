Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35C61BFC14
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Apr 2020 16:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgD3ODY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Apr 2020 10:03:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44771 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729463AbgD3ODX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 30 Apr 2020 10:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588255402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XofqElGzdh23Rr5CFB/Z/NuBK24FnrjfQX+BBYtZrbw=;
        b=KtL2M3t9waKrPifXYhfU0TC2C/CVe1FP9jtBAy19OkRvkcnZRWwMockLCGHZ/fjNPu3HAP
        M2/2+tZN26brVjfBYI1cw+qCRiCEk8BJfdj24XxMJk8iMzrvU75cvDr8nNdUiwuy8eCgTP
        66O/PEZBubOleDcho3/dWQJw5oX6fpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-0V5z4bL-OP6rmwbVaijmlQ-1; Thu, 30 Apr 2020 10:03:17 -0400
X-MC-Unique: 0V5z4bL-OP6rmwbVaijmlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC47E8018A6;
        Thu, 30 Apr 2020 14:03:15 +0000 (UTC)
Received: from work (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C31B45C1B0;
        Thu, 30 Apr 2020 14:03:14 +0000 (UTC)
Date:   Thu, 30 Apr 2020 16:03:09 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Filip =?utf-8?B?xaB0xJtkcm9uc2vDvQ==?= <r.lkml@regnarg.cz>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Any way to dump ext4 filesystem without file data blocks? (for
 later analysis)
Message-ID: <20200430140309.ndt5ao72evhhppeh@work>
References: <20200430134409.i5cxmmnbryx5hbui@baerbar.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430134409.i5cxmmnbryx5hbui@baerbar.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 30, 2020 at 03:44:09PM +0200, Filip =C5=A0t=C4=9Bdronsk=C3=BD=
 wrote:
> Hello,
>=20
> I have experienced several mysterious ext4 issues on remote machines
> with poor internet connection (mobile broadband) that are not easily
> physically accessible.
>=20
> I would like to download the filesystem image from the remote machine
> for local investigation but the partition is rather large (500GB in
> one instance) and I cannot easily upload that much data over the
> mobile connection.
>=20
> Is there any way to extract only filesystem metadata (superblock,
> inodes, directory data blocks, etc.) from the partition but not
> file data blocks? Ideally so that I could then reconstruct an
> identical filesystem image, only with file data blocks zeroed out.
>=20
> It seems it should be straightforwad to write such a tool but before
> I start doing so, I wanted to check whether somebody hasn't already
> written one. (It seems this might be a common enough need when
> debugging and developing filesystems.) Short googling around and
> searching list archive did not reveal anything.
>=20
> Thanks for any pointers.
>=20
> Filip Stedronsky

Hello Filip,

indeed there is a tool exactly for this purpose. It is called e2image
and it's part of the e2fsprogs. The manual page also have some useful
examples of how to use it.

Good luck.

-Lukas

