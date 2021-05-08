Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B974C37737C
	for <lists+linux-ext4@lfdr.de>; Sat,  8 May 2021 19:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhEHRzw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 8 May 2021 13:55:52 -0400
Received: from sonic311-24.consmr.mail.ne1.yahoo.com ([66.163.188.205]:42488
        "EHLO sonic311-24.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhEHRzv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 8 May 2021 13:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1620496487; bh=7mVkqI1FwBFoUXjji1+BimqA7SN7HHwU8wcQjbUSDqg=; h=Date:From:Subject:To:References:From:Subject:Reply-To; b=jw39DBL6Y1Mp1C7Jiu2ALHitlLUOcokQSAA7sdSr2qCJ0Zf1PunQKg6aU3HEIKz4aXux95C0ts663EXu7/68OzRIAywyEyNXEKZnPFxoKOujh/vKcF47PDf/DFn+f5wSjDDkaSbICEDyQzR8kLEtltb59Q8PnsMjABFLyBchduhrueyb5KKqbfppeDPii3SFSZ1eoG7Bq+C6Xhw62UNDnckPDAoSczsRIrDfHX3QTgjl+s3MXU54MCwq4fA0lbFcMxwbCqD5tFPYgpwglriP1npc5nn3kJa7QhqTVa8I1hrp3FsITh56xyBMej4+4V2FYQVDCex4CXuOL5PQYSmuCw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620496487; bh=CItmgl81pXPhSIrarDreiUdl4W/aYNdhTsnF6cDo2Zr=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=qV0AQ1OBH8JFdxgICU/QVGlFqh+QJ6HGMGvJlbA+VPfghhQkJVzddeJh6TsULPtKG3U4QxxqImveJatDT0Ase/h16gyhUxKe8jVE6Zk1BKQ6gaFSolNYbUJLlyrLxCiouz3iRtWupfOgXSBlQrk+F2BmRK1AycJuYjixLv9gAXcne+GFs52Ebw+X77qEDLTqhawGvHmOUQEfxswk6mNzZcRZ23xC/0hlaQZHW9Dhi77yZYUdNuLFTBewZRTei8HkasDLg6cd3WE/hGG91gU2lTAiV8yJum7MZuYMxjw23iPIRvEVDhE8PdtEv9kcb2y+kYsrlLtG0gGSYt+uCAKW7w==
X-YMail-OSG: hP.P_OgVM1mkDO3N6Y7kMziQayvhAfbE_EfI6GgfPi8P3KJiTqyzR11h268taaC
 p76._IdlC.DCCFXZVnc7XceX5nAqhqTRxYmbg_Owe0I2W9.ydszve98PIthqNF.GnLxtzNlmiKzx
 saN0qSs6NAkGBe1Kt2HDpOkfC96HQS5TB.QvkTtFX6CvaESmo5oikxqs96SUKh7PJWM.K2Rz48ef
 cfS7VN_MxVnPbf9VuufeXf2NGFh8lA1_JYBxGUT9U2FJ8poBnXD.bNl2cINHXAYCAJGJBgos0f8X
 BAM2P5aF9mQOb_YYc7MoUnaHRMmIGfF.Zgp9rCnzXJLIeoKfjr1SGcOVuXPtgLVGLLYqgGe3cPbO
 kiPU0Qdvy29Olk8UV1P2TpKL1x3QRYlhuVZm4FeFgBSSwozIsdiY85XRj51E4yt05W66KyD7DO8e
 KMnI2EGGONpxMlycn1N7AybvalOEkqMuXJuNt7VAY4Qcr8CQwzg208fOdAVkwNftz4OFjRuTOkQx
 YutL8ysmktv9kBo2OU117imknPpG95W0RODvwvRpZTOufz8r_xthpdwhQOBvkyc3br5MJZoQtcOX
 tfzOGka4iPLbrCa.vs8LXDRdYJfDKWLdbvnynv8qbvju9Qeod8x6MkerC6Bto7WXKpNGpXGQ6Oa0
 M64LO6y0bFOBsosI19H79dJU.Zpob6IiNLi6adGKfK2NHGgDARkfQ_A1.r65P_Gol4F177Q88ptH
 96V0b.916eAVElXRY0g6r0G2L9Zj56bTycbLuBiooWs1RZ0Mepq.lIW6FOjoDeJMKjROFGQXfgyM
 K8hQh_GPTC_edmWIGYKKagumEz_exkc7F3JeuzFBYd9CgnGCrUridq8FCy1LpMUYRkPfvBlWcmJC
 kP_KqnmCbK8gX8R_nCkuWm_UGFLMBcnwxdt_xcT4Wzanx0tU3Q9HEtMGyWKw_t1t9qO7YFZZ1Ga1
 MmGFSCTOc56TORsRe4RSoQW_c.RT07t.7wHdJrh8om6ecqucmGNH_wixfXFPwAGZlDSB8R2PnsH.
 8VhroP0Sa.AjMGEEiJ_OKk53BdcyVYjmOth4kXbSKbyY0.rshedaKdu9Cv3pXLunk5yYXuMvUvVa
 lTCBWYc0KayYXFD2YSsOkubK5dtlsCqxcfU9GsdPOWb.AAUt.q9TJTwlYXVwIOrz0p0eOqJE5xxk
 hF14JSDtaH8lhxuWBhJFNwnhdtFa5Tc1vpW9UfJNfUIIjRQD.YKHTl1ugzhuNUnN0dpJojPEg6z_
 4sMPH3tpyNv4Mx_kjglxYdTSIMMSxRwPe22cQNCojY95dTd1YLXhcW_iyMNOUPjIXH6TcDol__8X
 KuJiEspWfAbQ_VFdOWP2wpIC8Kx2GFM6rb7anMPvLQXTR2mjemAH6FqiN1oo38YxzNw1S0YfDxz8
 KoY_yf0HsdSKxvMWaXwbIfiZDn5aLcsn5E3hY26R.ZR4j3dgJdHEZb5rOcvdJZgQEOh.n515P5S6
 ecQOwIFVIPsvZOVBWqofv7SwXX9XUUiMx.ZxQpF43XZxvJMdjG49AXyb437UxNAQtObXm7Yu1GPK
 wAVa8VLEQcgEBOUYWFqE7R_g70zU9BYC3o4sbBzL63XLkN6KjOHyUIs5tU4o9Vd1EnAUOdyG2to9
 70jOoY6aKspZNkW0Fikjkxp3lNP1TGG571ej_UaP5Cqcy2xUL0SgPclOc6aiDYtLqxjzozjvoOCk
 ScXGbpp8oWG5aZKh5zwasjHpUT6wFSRGEp92KBONhVQVgKxqLzdAmWKlsqrt1OlfI0PFVvbw2c37
 SFil.T12Zi_dinsKFOBuA0Gzsq4k8DCESw0w2ptXMduMOLXe9UhtUu2hMfUeCg85kr_pSA1yvEQu
 AnDaDqV6pgNAJ3dgP1bc_8xVOu7s0iWiwlMO.pAD7dCKHVReIWV7C1aseR_E7PBl69uQeAHv.9Eu
 9GWBd1qv7beSEyktEcST8Q.y7Rv8yuWXmt1lNB2Ny2wKbCIA5EsxGhGdkBW94NUFWNq2ua7yXeAF
 Xa5vsB1.JjTd4JJswt_n8U3ZHUNw51oZPBi_EEb9ks_9M9QrOuZ3sRce6IhR1D09webQDuFR.LmH
 fLwrPmEWpw1MRMpi6qsJ_GY1DfpjEHYYoQE0tuyVOLPfYYnntPUlKnwO6OvuKwWdRcn5O0JM_y._
 uzwCNmLtAGhQOpbUjKCxWFCF6b4NS14BkdEFp5L4JNIm1iX.6X7j5BN65wGqbp3L3r7qx5kLRc7W
 8fUUV9h8WN.RQIyKafd4UnZPyF6A6yvtNxDaEdZBTXf3DVp7es09RCDspqosae6zYpeqv8oyd7Wp
 eEVK1s6PSp6NYmoQlKCfgUihhMk8ZfCYrwylBujDKfa_H.RhsxgQrhwNs0rC7Dj9XZSmQjfGSigq
 qLzsm85LtgILPwC5dpWZoOWiSwUyTLf6QORboVzaG8L7ufTELx.iLEhXL2VNG7ckbEvgUNQeUM9e
 _PM0HmDPTQyVIeSA_AcZbf7RSnsy.IDuWs4xXxpnhBLUY9Bpcuaz5c56cm6.StLQotPcahawHSjl
 eWityM1NTKTQAKuOqrJMag4fyNCGiu9dwsJ70aGLe.f55D.6.EM2aNRWt.qNh0rdS4cWvmMc6va7
 xOv_5ao53UAVZhd0HJw_jevIOftj.hePdl2foDJde_fkybFLpd4PQqx9NNKei2lzj
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sat, 8 May 2021 17:54:47 +0000
Received: by kubenode547.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f3c9a4d2d39b4d9365c6cf454859e55c;
          Sat, 08 May 2021 17:54:43 +0000 (UTC)
Date:   Sat, 08 May 2021 13:54:39 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: regression: data corruption with ext4 on LUKS on nvme with torvalds
 master
To:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        dm-crypt@saout.de, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
MIME-Version: 1.0
Message-Id: <1620493841.bxdq8r5haw.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1620493841.bxdq8r5haw.none.ref@localhost>
X-Mailer: WebService/1.1.18231 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/16)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

Using torvalds master, I recently encountered data corruption on my ext4=20
volume on LUKS on NVMe. Specifically, during heavy writes, the system=20
partially hangs; SysRq-W shows that processes are blocked in the kernel=20
on I/O. After forcibly rebooting, chunks of files are replaced with=20
other, unrelated data. I'm not sure exactly what the data is; some of it=20
is unknown binary data, but in at least one case, a list of file paths=20
was inserted into a file, indicating that the data is misdirected after=20
encryption.

This issue appears to affect files receiving writes in the temporal=20
vicinity of the hang, but affects both new and old data: for example, my=20
shell history file was corrupted up to many months before.

The drive reports no SMART issues.

I believe this is a regression in the kernel related to something merged=20
in the last few days, as it consistently occurs with my most recent=20
kernel versions, but disappears when reverting to an older kernel.

I haven't investigated further, such as by bisecting. I hope this is=20
sufficient information to give someone a lead on the issue, and if it is=20
a bug, nail it down before anybody else loses data.

Regards,
Alex.
