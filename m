Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0A94FF14
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2019 04:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfFXCIA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Jun 2019 22:08:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35531 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFXCIA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Jun 2019 22:08:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id a25so8792206lfg.2
        for <linux-ext4@vger.kernel.org>; Sun, 23 Jun 2019 19:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fWua/YqS4FEljrievWChxWON81LwIdhrq3+jjioZzeU=;
        b=XRzekx12x2R8BEza9NPZGwIGOrPwswPbQRhDWoOLF3Yfpx/jrUbZUbgCDaQ1lWFtcc
         3S8GL5iLJsMPb0EPOjtDLGuDxfLsEUbaCwp8/WB72LPvX/Fv0JqSqU1xsxhmqvu54VR+
         oO21ddEIYT5zCq2CRR74hE5nz4XimDWYTnIgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fWua/YqS4FEljrievWChxWON81LwIdhrq3+jjioZzeU=;
        b=V3tn0CYrcT0Qad/R3Eochmmxi8TVlHrsadBfYNuYiAUOSM3G4G7wL7mO9KhOEqpBi/
         MyQAk+SPOmSHyO81Ed9UC5bHIkObmQfsMa8HAX+oIwdJTNHjHgT6e7q+tNzu3USWA6yf
         ifwVIQaADE3PLTBKD1/Q/l63aPXR41ebxIaZNfzEBMSYsDtlu2SdZ0SuUAqmyf2qBmdx
         +JuOiQRSGLepwZyYsUD+czcxWmsonILHDACdGx1njb8p0ZI1hGjusKurPyzZrp7Duzsb
         mYNP4zvqB9Nnnq9DblkpKVxItEcqozlBcxXLacZtteVjzmqpjDiiywW+i4VxORhuO4Ex
         j6Vg==
X-Gm-Message-State: APjAAAVH28kBjWg11AJwEtlZY1o532h0yxPXp2AmlbixhVvC8lYKHhgW
        sjiXr4A7h3+ok11X2iGXzV/j5w4Auk7FDADcE88U17fCQC8=
X-Google-Smtp-Source: APXvYqw5GB8w+Rr7ZCSldCfQW9Z++tyCAuBFim39MNoH6h0Nz9D6axObPB4rzu6i0my/bgVMZFoWONlA3soFypmx88s=
X-Received: by 2002:a19:230f:: with SMTP id j15mr35109270lfj.122.1561327778613;
 Sun, 23 Jun 2019 15:09:38 -0700 (PDT)
MIME-Version: 1.0
From:   Steven Swanson <swanson@eng.ucsd.edu>
Date:   Sun, 23 Jun 2019 15:09:27 -0700
Message-ID: <CABjYnA7JXEwoxyE+2QisupAQuG0YJ3GUY24QooqY3vAZoFZOLg@mail.gmail.com>
Subject: Call for participation: Persistent Programming In Real Life
To:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

You are invited to attend the first annual Persistent Programming in
Real Life (PIRL) meeting (https://pirl.nvsl.io/).  PIRL brings
together software development leaders interested in learning about
programming methodologies for persistent memories (e.g. NVDIMMs,
Optane DC) and sharing their experiences with others.  This is a
meeting for developer project leads on the front lines of persistent
programming, not sales, marketing, or non-technical management.

PIRL features a program of 18 presentations and 5 keynotes from
industry-leading developers who have built real systems using
persistent memory.  They will share what they have done (and want to
do) with persistent memory, what worked, what didn=E2=80=99t, what was hard=
,
what was easy, what was surprising, and what they learned.

This year=E2=80=99s keynote presentations will be:

* Pratap Subrahmanyam (Vmware): Programming Persistent Memory In A
Virtualized Environment Using Golang
* Zuoyu Tao (Oracle): Exadata With Persistent Memory =E2=80=93 An Epic Jour=
ney
* Dan Williams (Intel Corporation): The 3rd Rail Of Linux Filesystems:
A Survival Story
* Stephen Bates (Eideticom): Successfully Deploying Persistent Memory
And Acceleration Via Compute Express Link
* Scott Miller (Dreamworks): Persistent Memory In Feature Animation Product=
ion

Other speakers include engineers from NetApp, Lawrence Livermore
National Laboratory, Oracle, Sandia National Labs, Intel, SAP, Redhat,
and universities from around the world.  Full Details are available at
the PIRL Website: https://pirl.nvsl.io/.

PIRL will be held on the University of California, San Diego campus at
Scripps Forum, a state-of-the-art conference facility just a few
meters from the beach.

PIRL is small.  We are limiting attendance this year to under 100
people, including speakers.  There will be lots of time for informal
discussion and networking. Early registration ends July 10th.

If you have any questions, please contact Steven Swanson (swanson@cs.ucsd.e=
du).

Organizing Committee

Steven Swanson (UCSD) Jim Fister (SNIA) Andy Rudoff (Intel) Jishen
Zhao (UCSD) Joe Izraelevitz (UCSD)
