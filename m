Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206D2DAF2
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2019 06:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbfD2EQl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Apr 2019 00:16:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42320 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfD2EQl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Apr 2019 00:16:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id r72so3671070ljb.9
        for <linux-ext4@vger.kernel.org>; Sun, 28 Apr 2019 21:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=krJo5CW3ItKWoVcAOx9/bRz7prNBjTOsOHnuI8ACte4=;
        b=pjxL1hDtyqKR4T+BGeqdfUudedcJDo+nOpRrpzVfk/ghJDYYE+Ch4NIDEi6s/ICMia
         7BA4rFIu+cLH2HVHEfDDsBXge2JoZQNGS1AyaOrnjDq0ctE9QoPIpL73wTxiLt5pyrZW
         gs4LOK5aVuaB02imNJAFfnH1/A0EoTJA7lI3LQnn1LfF1j/bdIHso61vw4jWXKuWeu/n
         Nj1LcPZJcWYR2Fw6dOVho9kMheIFee/A7lT7RI089MqyZ87rktaJjYuPROLlH85MkNo5
         M2RFETXrR9+z8fA3XkUstb5ZkI46XN9OmjXObahwBr0k0vtebs0aZNSIG1CMzOLQTiCH
         d4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=krJo5CW3ItKWoVcAOx9/bRz7prNBjTOsOHnuI8ACte4=;
        b=TZHGlbVX68bVJzg5GuK+YIWrhF+TB7/EYfLj3vPsut0G14Mea95GfWg+eDmEiD07lK
         1YLVLpEePXTAogtydFZqKuvhrSC+VagYuTBdStmnWGopx4+GckPnrgrFgjqg9114DwMc
         4AVKiN8YDMqjEO59FWF5N3jBkhEipvHb66CkGwNme3xFwrKsxmaiWiIYk1cUhhC8SeIJ
         5T77phDhbXPlG3HDF4tz2Eb7K/AJ+FsfkWfWkmwwS2bmwXplz8J8GfTlmhgwtusnruM5
         tc0GDVSDU++F6LJ/E1ISU1loM+7zoc1c8e8toLV9y8KzqN6CTe2Ubn3ZNLVD6eODtZIU
         phZg==
X-Gm-Message-State: APjAAAWVCHx0mqwYCIswS2bfkpbC9zRQpanHWpn4/RS78NpCxhUPrG9A
        6qtXMS/c/vgnBtxrN1vzL48=
X-Google-Smtp-Source: APXvYqzkZqs1TronM0rglqwkOHC64eFJcHZKZVGS5bmS8TKgE6AyZ1Rg6UnkFyK247GeHZu9kOHEkw==
X-Received: by 2002:a2e:988e:: with SMTP id b14mr6614365ljj.126.1556511398914;
        Sun, 28 Apr 2019 21:16:38 -0700 (PDT)
Received: from [192.168.3.100] ([95.174.108.185])
        by smtp.gmail.com with ESMTPSA id y23sm6972896lfy.31.2019.04.28.21.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 21:16:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsck: Do not to be quiet if verbose option used.
From:   Alexey Lyashkov <alexey.lyashkov@gmail.com>
In-Reply-To: <20190428233847.GA31999@mit.edu>
Date:   Mon, 29 Apr 2019 07:16:36 +0300
Cc:     Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Alexey Lyashkov <c17817@cray.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DF9A5AD-ADCA-452B-8242-FE43946002ED@gmail.com>
References: <20190426130913.9288-1-c17828@cray.com>
 <20190428233847.GA31999@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Theodore,

Usecase is simple. User use a -p with -v flag,
in this case, -p block any messages on console in case it successfully =
fixed.
It=E2=80=99s OK _without_ -v flag, situation is different with -v flag.
In this case, user expect to see mode debug info about check/fix =
process,
and =C2=ABno messages=C2=BB in this mode confuse a user, as he think =
=C2=ABno messages=C2=BB =3D=3D =C2=ABno bugs fixed=C2=BB,
but it=E2=80=99s not a true in common way.
=46rom other side, -p print a messages about fix process, but not for =
bitmaps, it=E2=80=99s source of additional
 confuse for the user, as he lack an info about FS changes during e2fsck =
run.


> 29 =D0=B0=D0=BF=D1=80. 2019 =D0=B3., =D0=B2 2:38, Theodore Ts'o =
<tytso@mit.edu> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
>=20
> On Fri, Apr 26, 2019 at 04:09:13PM +0300, Artem Blagodarenko wrote:
>> From: Alexey Lyashkov <c17817@cray.com>
>>=20
>> e2fsck don't print a message if 'p' option used and error can be =
fixed without
>> user assistance,  but 'v' option asks to be more verbose, so user =
expect to
>> see any output. But not.
>> Fix this, by avoid message suppress with verbose option used.
>>=20
>> Change-Id: I358e9b04e44dd33fdb124c5663b2df0bf54ce370
>> Signed-off-by: Alexey Lyashkov <c17817@cray.com>
>> Cray-bug-id: LUS-6890
>=20
> I need to understand the use case of what you are trying to do here.
> The preen and verbose options were never intended to be mixed and this
> patch changes what the verbose flag does at a fairly fundamental
> level.  I'm not sure the results will be correct and they will almost
> certainly be surprising.
>=20
> So (a) what is the user trying to do, and (b) what does the user want
> to be trying to do?  Preen was intended to be used as part of the boot
> process, when multiple e2fsck's would be running in parallel, and so
> you don't *want* much in the way of verbosity.
>=20
>    	  	      	     	    - Ted

