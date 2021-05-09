Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116113774F6
	for <lists+linux-ext4@lfdr.de>; Sun,  9 May 2021 04:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhEICbF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 8 May 2021 22:31:05 -0400
Received: from sonic315-55.consmr.mail.gq1.yahoo.com ([98.137.65.31]:36918
        "EHLO sonic315-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229620AbhEICbE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 8 May 2021 22:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1620527402; bh=ueIl4x8R37izX0Gh+GlY985UzorU1ofhHJDIzVNG++Q=; h=Date:From:Subject:To:References:In-Reply-To:From:Subject:Reply-To; b=sTD95D4gy+Vcqfdm9MRrhFLgK+32S9AeoOouq63VuJwOeCGgOXgTCc6ELOHmStNbQFexs593GFDvf8atd99OtINT/E1CkDbj3aAMsffzYZhgK2cIAqRNZa7/W2tYO1Z3GyZRYosld+QNZUskmsb/P3bpWdMAPNF30Sp2wx/voRu+HETrknMnipBL7lXkUeY+B9uTLy2EXrcUv3RYLzN5X6sZ0hi7v8Gh6G7Si7KyRUBfP3jkgFBawinR9tAD7DLMarj/Z5QM+Dbuft553zk0UD8b3Sj4gyXMlKWUDc3z8uSxNupXKQj39f9F2rIJqpwooByxjodos/UrT95rxqZvmA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620527402; bh=Ksi/3rA1jmDcJr2jceaBfwpzHRN06fYLNlpsY0Ymy7E=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=l1TdtQVEneOnH5uyPqMeqcaFb6SjQW2moX2VGCQXiarSVzMYTPhAStSNyR4yiMw9pjVHuA9qJNUqNkOoRKS1JRyBRkZVpqRpwnTHONB7AmCQL/8JcgmvpOBly7D2Jlwx727ms0/4XeZZFSp0aX908XqhdEU4k0aQPk1b/ZMh/cjWqTv1VWKHGMnYkHi77ZbjSbrsaGCBLIiB0dVqWg/BE45WUNbw3mn1iWKafFQRPin4TOSuucXmM3jD5xjw3ZE+yjBrrQ+b5NBDoM5q36Im/vRwHchOG67aF34n1ESlT73FSQSaE6OuFsS/Fmus3CigDkj/PiV01SXlUOaNavxlDg==
X-YMail-OSG: EgeiaXkVM1mD0vvW4oDu7C7lIv8_9b2iJCYw9gEGiBLiPrYE9JNtm4DHccbo60j
 Hr7qW.0bzv9MKlY0G0fj6O7Y7gOgLjHvM_Y8U77LjGISal8B62Ti5O2zpmN5GTZLzjTslfrZTQf_
 H508yT.PwsypXm66QCn.SZ1.gKl4kydeOftY4Iom9cZKZ_Rq8Y7_nCAMzoJrBHQ.BqKt2_f6DSC6
 7hTUiIKn90vnW3.CuLuo.a0dphl9IXc4y0uCKyqL7AWwxkT5k.36FQjinPxUOpzcUlEXoGYLHIOC
 icJ2uzHXNpsOkE9nQnOZ7lZUu.VcTbEESvfK1DjB.BC_ykwgcqcXTSET7yV8B5Dj4xhV6zHYwpzN
 gKs3H4qNk7pWfZvqxjWtSADVZxqFCMYy2bFYqTbCh0B7f_n4qj5SDeN74VisyR0kF0acOfYf1SbH
 vkTuSMsvtGA_yS.2B.EfXB15HnoEZ9.4iKDdVRpJlNpsTqFjruQez1Pil2K_4qV2PYRIAUsC3gMh
 P0zYzlJZZ4_Vwytw0G4HCeKBAc2W5HyTjp90OvBwwBR2CoE92Pl_SacyguvxLYptVjPoJPGSnotF
 qa12AGmoTcuRdjpevTTJ4.GqGEyFfKHdP99C8aWUS2bJKSq2pM049..npyEoFWjgI00I9zH7CHef
 o9G5AoVxnDio6xM9QZveKEp8zsPlhwa6JQ1GJwIyGvHN_uiKi_Ym.fCWUMzkOrY52_QVTJHF_Dax
 cWju2DqRKonKWi_SN8wGynu4kmhSziHc5R6ZJoMJ.riw4FiQY0etdfQIUh98bIU2iIBpEgfhw4R0
 wJ2MrdrjTct6YuZb_X_Ix2bTeeDfpzrWSrXL9vBBSRw.duG6f026iVB9rROPJTJlkqTQ57xT4RBA
 TrDhqlAr__0YL9Ojgkq0tFtHHvIGpb2W.jN6.pClT6OxKNnuwtYn2kSBq_l1y8PmlKURSvWCqOGR
 MNVDHcOqWaQT8EVE_T85QB.lBQ6fr.ccF4po8Hv73QZwlOKTxV4RDxecQmN2AnGd85b46.2e9YFp
 WZyJGFlJ4y_n8wghA9ZmccDRAwXj1026KWqIb_kq2cavJNHoLhbkwbVp5aSbt4x6i3UHlQaWWC.8
 m2WPH4ryk0cr0zdzTQsIJ9IJQrurmOQHDdKJllz9hN3OoyiaYn2VFShK.xjtWKVxrtc01Kd8Yvcf
 gK3JHxNhljc0ugoIuPqSI6g1i4YmV95M9Vd4oW910V080GtqQeL70rp1ow6eRjhoGBis_4tEkSe3
 TgAHp6nnjYLkgq_1PcVGzKkibDoxHysGQIOR5eqaR9A7sULmqmS2ZUQBx5RuCcKaTMHW_mIT7AGq
 QtEWK.DcchvrvpPYeC9QC4Y_QLNmCClK80a1yCKU0s0KvL.7Dgv.PTPCH09EEAbF54nTN654f2_c
 _NOw_KV7J22ddj6fjpCvCYe6XsNUOqO8kaCAsa040fFnv5xmUUKl4XK.DQIj7KDqt6QH68XF6I_o
 f9yFe95r3Nv7vgR5NCGZ3iBJoW1Y1xFsnDgjAqYEZFKIF_9hsVQM981JiipT67B0OqdWgK5.BhYC
 RtZRLGSXM_IT_zvno07Q7VHlFH0XbQlH7U.qnj_0WyjWrBU2hdS2xI2DmRTdISeQFHfrZZL2f3lc
 916OZExxq7qBe5GnFdZj.5UW8EdXINRgC4Drsh74HCZIXeDF4StYaLs65AnrlCi5pl8ur2JSmJyb
 w.VGcJJFJ.uscHFOlueZbb5ulYN45UAMAA04MsTWSf_XI0gpDSCpzeovN5q74bwUnSwJQoe5vNX_
 XSaE.Ke3jIwkHpXx07udRNp4LW6svFDn7HXBvFE5R8gfTPC2HoBfAM0yDYBBtvdXRvOqVKmK5Op8
 DiN35YtBjkTwViFUV6_jejbyhaUerqNzU6YkjBjhKs.UIs8VV1SgIEecGZ2KNVPyj3ElwTBK4ccf
 8VNMRY8ZA46cRtJbrz72n5kyLVWzBoAWmRGL_AVSQ.b2kWMd5APU0Lte2hIYQ88ROoLIXH74TCHr
 IUA9ekI5hESNV05fz4lyPVeE_zI8n4x7oEWQQkX1_MV8KOb5W6ZbPk.GU_Z38SaSU5FZHplokOWe
 pn3HEOk10PheR8gogz5U569vxiyDVS6QuVuIZWuYwLplPJgg7Plqjw7PhqGn8yfE1z_3rskUBeuA
 BCYPb3JIKEMgomHY4p.vgsd901NBy8Vxy15rxXdFZWBiAaLbdZwADPLPydVAfJsEn_j3hRRuanuq
 vzv6lUj6ESvkjgFde6HMB1weNidOK0muCFT6BBvA_5mEcn9tVxmGSIZtVkOrHVRmqD1gRs0kWO4q
 xuwlHkMVqt1nImX048wubdy_kGFmAkvswbf0B_E2L9pd1LhDXxXcXUVjLLu9tI2rhkWGF9TcGvSV
 c3IB6ao33ge3pTqwj2B5NFnZX1VRr4TuByCbDVWav8cZD7Dqh4tryiuIVDbSooHb8qZ5Pm4IF2MG
 kla.uUIbI2PZTBk7FVM33BJ8sqhtXaIlK2FBCV0hIqQRlzXyXTQwDSRA6AOGjM5hmsvXp0d0ZW58
 _MlM0vtsremlHfHZRncsCCKuPkTvsqWlCBxwMZd8rEXKp.mJi1ptZWfGRt5P5bp3Qy4uigMm5Ssf
 hlmz84befS5qfZgb0ochSbn9NHxhJlEAccDIZygamDW0zZwSYopV58FBKZI4sSydeX.PYiQ0KUW4
 dgSsev.ifJXe2ZOihZ7_4tj7IUdkgb1MwDiGVk4qyOcdWJ0eQoKys456W_uGuosle.GUbPxg1aQD
 NNukk94TvpwgwGV1k.P3bBPHDSE9aJTDa1Pjpyz_KdC2bygVz0qxaEzaoWjbtYPVrs4Cfw_88c5n
 9vlPeulAjLl2qcU86wpunZtMg4mjTle_OPYMfZUs-
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sun, 9 May 2021 02:30:02 +0000
Received: by kubenode569.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f2d11dc1d343c0ca0261cac91088d59a;
          Sun, 09 May 2021 02:30:00 +0000 (UTC)
Date:   Sat, 08 May 2021 22:29:57 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
To:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        dm-crypt@saout.de, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Changheun Lee <nanich.lee@samsung.com>, bvanassche@acm.org,
        yi.zhang@redhat.com, ming.lei@redhat.com, bgoncalv@redhat.com,
        hch@lst.de, jaegeuk@kernel.org
References: <1620493841.bxdq8r5haw.none@localhost>
In-Reply-To: <1620493841.bxdq8r5haw.none@localhost>
MIME-Version: 1.0
Message-Id: <1620526887.tg1zx7w5np.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.18231 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Excerpts from Alex Xu (Hello71)'s message of May 8, 2021 1:54 pm:
> Hi all,
>=20
> Using torvalds master, I recently encountered data corruption on my ext4=20
> volume on LUKS on NVMe. Specifically, during heavy writes, the system=20
> partially hangs; SysRq-W shows that processes are blocked in the kernel=20
> on I/O. After forcibly rebooting, chunks of files are replaced with=20
> other, unrelated data. I'm not sure exactly what the data is; some of it=20
> is unknown binary data, but in at least one case, a list of file paths=20
> was inserted into a file, indicating that the data is misdirected after=20
> encryption.
>=20
> This issue appears to affect files receiving writes in the temporal=20
> vicinity of the hang, but affects both new and old data: for example, my=20
> shell history file was corrupted up to many months before.
>=20
> The drive reports no SMART issues.
>=20
> I believe this is a regression in the kernel related to something merged=20
> in the last few days, as it consistently occurs with my most recent=20
> kernel versions, but disappears when reverting to an older kernel.
>=20
> I haven't investigated further, such as by bisecting. I hope this is=20
> sufficient information to give someone a lead on the issue, and if it is=20
> a bug, nail it down before anybody else loses data.
>=20
> Regards,
> Alex.
>=20

I found the following test to reproduce a hang, which I guess may be the=20
cause:

host$ cd /tmp
host$ truncate -s 10G drive
host$ qemu-system-x86_64 -drive format=3Draw,file=3Ddrive,if=3Dnone,id=3Ddr=
ive -device nvme,drive=3Ddrive,serial=3D1 [... more VM setup options]
guest$ cryptsetup luksFormat /dev/nvme0n1
[accept warning, use any password]
guest$ cryptsetup open /dev/nvme0n1
[enter password]
guest$ mkfs.ext4 /dev/mapper/test
[normal output...]
Creating journal (16384 blocks): [hangs forever]

I bisected this issue to:

cd2c7545ae1beac3b6aae033c7f31193b3255946 is the first bad commit
commit cd2c7545ae1beac3b6aae033c7f31193b3255946
Author: Changheun Lee <nanich.lee@samsung.com>
Date:   Mon May 3 18:52:03 2021 +0900

    bio: limit bio max size

I didn't try reverting this commit or further reducing the test case.=20
Let me know if you need my kernel config or other information.

Regards,
Alex.
