Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A680133584
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2020 23:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgAGWMH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jan 2020 17:12:07 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:44772 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAGWMH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jan 2020 17:12:07 -0500
Received: by mail-pl1-f170.google.com with SMTP id az3so251563plb.11
        for <linux-ext4@vger.kernel.org>; Tue, 07 Jan 2020 14:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=fI3ATwnlkkrV4vo8SIuuyMSN2w0khxKYSBKcGTLPW+o=;
        b=gFOJEn86sThNstJZcLp+Ka0chNht/nAOXGDRXd8fuxMMBs9r7stc1ARNEJA9cATf6H
         JObjWWidrN2DUln6ExndYUZM1ImOXX12iVfl22+TwXCoa0Ji11lw/sbTld0epq4lxhap
         FA/48SStrTlwf0JlvhFIyvk+iNhnNFsRfzyokwtfO4sgpVjMTU7zHEg4jatsH3mcSaK6
         mU0FTksf/uA5jNWs12XFojomCbar1oLisgXRoayneOKlwJgCKYJkX8ljYQD2NNXBN6gu
         g1RcfP5HEX/zNV2xKiWhhthc/V/aE+3eyfWNKtmuYtJ5/0zRa4sJD8eL8EOsOuCsAi/b
         QJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=fI3ATwnlkkrV4vo8SIuuyMSN2w0khxKYSBKcGTLPW+o=;
        b=PwJGzm921MxhED9Sy+UFcyrkga5KkLscwID48WpYj1fYEZu76cLH1MFFveohf+0/g9
         2K0xtFAunVqmRqTcVhu6yFwGzK2pM/msvy02+v1Equ+b1s1Y1w6Obor7oOjeveLxNiod
         ibQjJijf3jIjMsu4WEvDBykeXnhvh6EvWFFxPmLvrWR4UOFRLZ4FDpOSsOyr65bXmaEq
         /jcT/ak24Mm1bktAZW8PVx7qPf+V4gSPBjPLDrNiUa9LjuP9FyVMIfgvYxP1oa+R+djv
         OWMRLZXyRGe8HTYsp5bl0FTnHXdkRneqrm7mbrstuSZNKFyT56I53rfbkQIaWUncavPK
         q0gA==
X-Gm-Message-State: APjAAAX8Vxa+RzYMXQD/6qHoLbyyTqxLgTGLucxDwbpOgOBuT3+Qtz6j
        n8YIlQ4IfOfdNx868T7DSXXzaQ==
X-Google-Smtp-Source: APXvYqx2cLHG88jnojNGxn/gZg3hIca8TPVlWO5Iz4qK2Ms2yCQcC29xVqtjwDGOHIZahCsDxbWLGQ==
X-Received: by 2002:a17:902:8bc4:: with SMTP id r4mr1881353plo.291.1578435126281;
        Tue, 07 Jan 2020 14:12:06 -0800 (PST)
Received: from [192.168.10.175] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id j38sm749371pgj.27.2020.01.07.14.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 14:12:05 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: About BUFFER_TRACE macro in include/linux/jbd2.h
Date:   Tue, 7 Jan 2020 15:12:03 -0700
Message-Id: <5FFDC259-0697-4505-B7DB-3E633CD03666@dilger.ca>
References: <20200106083020.2EF41AE064@d06av26.portsmouth.uk.ibm.com>
Cc:     linux-ext4@vger.kernel.org
In-Reply-To: <20200106083020.2EF41AE064@d06av26.portsmouth.uk.ibm.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ritesh,
There were somewhat patch versions posted by Andrew Morton (akpm)
that may have more functionality.

Note that the block layer no longer needs to be patched for this to be
used. Instead you can use dm-flakey to cause it to discard writes to the
block device.=20

Cheers, Andreas

> On Jan 6, 2020, at 01:30, Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>=20
> =EF=BB=BFHello Community,
>=20
> A very happy new year to all of you!! :)
>=20
> Had some query on BUFFER_TRACE macro. Here it goes:-
>=20
> While debugging some issue w.r.t jbd2/bh I came across this empty macro
> definition of BUFFER_TRACE in include/linux/jbd2.h.
> Though this is called from multiple places, but I could not find any
> definition of this as such.
>=20
> I could see some patches on mailing list which are still calling this
> macro. So that means I am definitely missing something here.
>=20
> Could you please help me understand how can one use this "BUFFER_TRACE"
> macro for debugging? I could not find any ftrace event related
> to this macro.
>=20
> For my debugging as of now I ended up creating a file in
> include/trace/events/buffer_debug.h and added the definition
> of BUFFER_TRACE macro there.
>=20
> On more googling I did find some old patch which enabled CONFIG_BUFFER_DEB=
UG.
> http://people.redhat.com/sct/patches/ext3-2.4/for-2.4.19/98-debug/00-ext3-=
debug.patch
> But this seemed pretty old and I could not find anything latest on this
> which is related to above patch.
>=20
> Any pointers pls?
>=20
> -ritesh
>=20
